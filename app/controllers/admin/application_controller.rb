# frozen_string_literal: true

module Admin
  class ApplicationController < ApplicationController
    layout -> { turbo_frame_request? ? false : 'admin/application' }

    before_action :authenticate_user!
  end
end
