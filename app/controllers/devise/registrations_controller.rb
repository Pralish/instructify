class RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash = {})
    if hash[:email]
      self.resource = resource_class.where(email: hash[:email]).first
      if self.resource && self.resource.respond_to?(:invited_to_sign_up?) && self.resource.has_not_signed_up_yet?
        self.resource.attributes = hash
      else
        self.resource = nil
      end
    end
    self.resource ||= super
  end
end