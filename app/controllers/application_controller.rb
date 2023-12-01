# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include TenantResolvable
  include Pagy::Backend

  def current_member
    Memeber.find_by(user: current_user, organization: current_tenant)
  end
end
