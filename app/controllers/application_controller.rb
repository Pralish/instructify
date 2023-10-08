class ApplicationController < ActionController::Base
  include TenantResolvable
  include Pagy::Backend

  def after_sign_out_path_for(user)
    new_user_session_path
  end
end
