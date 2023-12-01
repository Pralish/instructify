class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :invitable_from_invitation_token, only: [:edit, :destroy]

  def new
    @invitable = invitable_class.new
  end

  # POST /resource/invitation
  def create
    @invitable = invitable_class.invite!(invite_params, current_user)
  end

  # GET /resource/invitation/accept?invitation_token=abcdef
  def edit
    set_minimum_password_length
    @invitable.invitation_token = params[:invitation_token]
  end

  # PUT /resource/invitation
  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    @invitable = invitable_class.accept_invitation!(update_resource_params)

    unless @invitable.errors.any?
      sign_in(:user, @invitable.user)
    end
  end

  # GET /resource/invitation/remove?invitation_token=abcdef
  def destroy
    @invitable.destroy
  end

  protected
    def invitable_from_invitation_token
      @invitable = invitable_class.find_by_invitation_token(params[:invitation_token], true)
    end

    def invite_params
      devise_parameter_sanitizer.sanitize(:invite)
    end

    def update_resource_params
      devise_parameter_sanitizer.sanitize(:accept_invitation)
    end

    def translation_scope
      'devise.invitations'
    end

    def invitable_class
      Member
    end
end