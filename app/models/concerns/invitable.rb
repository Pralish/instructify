module Invitable
  extend ActiveSupport::Concern

  attr_accessor :skip_invitation
  attr_accessor :completing_invite
  attr_reader   :raw_invitation_token

  included do
    include ::DeviseInvitable::Inviter

    belongs_to :invited_by, optional: true
  end

  # Saves the model and confirms it if model is confirmable, running invitation_accepted callbacks
  def accept_invitation!
    if self.invited_to_sign_up?
      @accepting_invitation = true
      self.invitation_accepted_at = Time.now.utc
      self.invitation_token = nil

      if self.save
        self.user.confirm!
      else
        self.rollback_accepted_invitation if !saved
        @accepting_invitation = false
      end
    end
  end

  def rollback_accepted_invitation
    self.invitation_token = self.invitation_token_was
    self.invitation_accepted_at = nil
  end

  # Verify wheather a user is created by invitation, irrespective to invitation status
  def created_by_invite?
    invitation_created_at.present?
  end

  # Verifies whether a user has been invited or not
  def invited_to_sign_up?
    accepting_invitation? || (persisted? && invitation_token.present?)
  end

  # Returns true if accept_invitation! was called
  def accepting_invitation?
    @accepting_invitation
  end

  # Verifies whether a user accepted an invitation (false when user is accepting it)
  def invitation_accepted?
    !accepting_invitation? && invitation_accepted_at.present?
  end

  # Verifies whether a user has accepted an invitation (false when user is accepting it), or was never invited
  def accepted_or_not_invited?
    invitation_accepted? || !invited_to_sign_up?
  end

  # Reset invitation token and send invitation again
  def invite!(invited_by = nil, options = {})
    # This is an order-dependant assignment, this can't be moved
    was_invited = invited_to_sign_up?

    # Required to workaround confirmable model's confirmation_required? method
    # being implemented to check for non-nil value of confirmed_at
    # if new_record_and_responds_to?(:confirmation_required?)
    #   def self.confirmation_required?; false; end
    # end

    generate_invitation_token if self.invitation_token.nil?

    self.invitation_created_at = Time.now.utc
    self.invitation_sent_at = self.invitation_created_at unless skip_invitation
  
    if save(validate: false)
      deliver_invitation(options) unless skip_invitation
    end
  end

  # Verify whether a invitation is active or not. If the user has been
  # invited, we need to calculate if the invitation time has not expired
  # for this user, in other words, if the invitation is still valid.
  def valid_invitation?
    invited_to_sign_up? && invitation_period_valid?
  end

  # Only verify password when is not invited
  def valid_password?(password)
    super unless !accepting_invitation? && block_from_invitation?
  end

  # Prevent password changed email when accepting invitation
  def send_password_change_notification?
    super && !accepting_invitation?
  end

  def unauthenticated_message
    block_from_invitation? ? :invited : super
  end

  def clear_reset_password_token
    reset_password_token_present = reset_password_token.present?
    super
    accept_invitation! if reset_password_token_present && valid_invitation?
  end

  # Deliver the invitation email
  def deliver_invitation(options = {})
    generate_invitation_token! unless @raw_invitation_token
    self.update_attribute :invitation_sent_at, Time.now.utc unless self.invitation_sent_at
    Devise.mailer.send(:invitation_instructions, @raw_invitation_token, options)
  end

  # provide alias to the encrypted invitation_token stored by devise
  def encrypted_invitation_token
    self.invitation_token
  end

  def confirmation_required_for_invited?
    respond_to?(:confirmation_required?, true) && confirmation_required?
  end

  def invitation_due_at
    return nil if (self.class.invite_for == 0 || self.class.invite_for.nil?)
    #return nil unless self.class.invite_for

    time = self.invitation_created_at || self.invitation_sent_at
    time + self.class.invite_for
  end

  def invitation_taken?
    !invited_to_sign_up?
  end

  protected

    def block_from_invitation?
      invited_to_sign_up?
    end

    # Checks if the invitation for the user is within the limit time.
    # We do this by calculating if the difference between today and the
    # invitation sent date does not exceed the invite for time configured.
    # Invite_for is a model configuration, must always be an integer value.
    #
    # Example:
    #
    #   # invite_for = 1.day and invitation_sent_at = today
    #   invitation_period_valid?   # returns true
    #
    #   # invite_for = 5.days and invitation_sent_at = 4.days.ago
    #   invitation_period_valid?   # returns true
    #
    #   # invite_for = 5.days and invitation_sent_at = 5.days.ago
    #   invitation_period_valid?   # returns false
    #
    #   # invite_for = nil
    #   invitation_period_valid?   # will always return true
    #
    def invitation_period_valid?
      time = invitation_created_at || invitation_sent_at
      self.class.invite_for.to_i.zero? || (time && time.utc >= self.class.invite_for.ago)
    end

    # Generates a new random token for invitation, and stores the time
    # this token is being generated
    def generate_invitation_token
      raw, enc = Devise.token_generator.generate(self.class, :invitation_token)
      @raw_invitation_token = raw
      self.invitation_token = enc
    end

    def generate_invitation_token!
      generate_invitation_token && save(validate: false)
    end

    def new_record_and_responds_to?(method)
      self.new_record? && self.respond_to?(method, true)
    end

  module ClassMethods
    # Attempt to find a user by its email. If a record is not found,
    # create a new user and send an invitation to it. If the user is found,
    # return the user with an email already exists error.
    # If the user is found and still has a pending invitation, invitation
    # email is resent unless resend_invitation is set to false.
    # Attributes must contain the user's email, other attributes will be
    # set in the record

    def invite!(attributes = {}, organization = nil, invited_by = nil, options = {})
      new_user = true

      unless user = User.find_by(email: attributes[:email])
        new_user = true
        user = User.create!(email: attributes[:email], password: random_password)
      end

      invitable = find_or_initialize_by(user: user, organization: organization)
      invitable.invited_by = invited_by

      invitable.errors.add(:email, :taken) if invitable.persisted? && (invitable.invitation_taken? || !self.resend_invitation)
      
      invitable.invite!(nil, options.merge(validate: false)) if invitable.errors.empty?

      user.destroy if invitable.errors.present? && new_user
      invitable
    end

    # Attempt to find a user by it's invitation_token to set it's password.
    # If a user is found, reset it's password and automatically try saving
    # the record. If not user is found, returns a new user containing an
    # error in invitation_token attribute.
    # Attributes must contain invitation_token, password and confirmation
    def accept_invitation!(attributes = {})
      original_token = attributes.delete(:invitation_token)
      invitable = find_by_invitation_token(original_token, false)
      if invitable.errors.empty?
        invitable.assign_attributes(attributes)
        invitable.accept_invitation!
      end
      invitable
    end

    def find_by_invitation_token(original_token, only_valid)
      invitation_token = Devise.token_generator.digest(self, :invitation_token, original_token)

      invitable = find_or_initialize_with_by(invitation_token: invitation_token)
      invitable.errors.add(:invitation_token, :invalid) if invitable.invitation_token && invitable.persisted? && !invitable.valid_invitation?
      invitable unless only_valid && invitable.errors.present?
    end

    Devise::Models.config(self, :invite_for)
    Devise::Models.config(self, :invitation_limit)
    Devise::Models.config(self, :invite_key)
    Devise::Models.config(self, :resend_invitation)

    private

      # The random password, as set after an invitation, must conform
      # to any password format validation rules of the application.
      # This default fixes the most common scenarios: Passwords must contain
      # lower + upper case, a digit and a symbol.
      # For more unusual rules, this method can be overridden.
      def random_password
        length = respond_to?(:password_length) ? password_length : Devise.password_length

        prefix = 'aA1!'
        prefix + Devise.friendly_token(length.last - prefix.length)
      end
  end
end