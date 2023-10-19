# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include TenantResolvable
  include Pagy::Backend
end
