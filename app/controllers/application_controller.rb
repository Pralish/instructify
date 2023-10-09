class ApplicationController < ActionController::Base
  include TenantResolvable
  include Pagy::Backend
end
