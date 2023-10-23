# frozen_string_literal: true

module Student
  class ApplicationController < ApplicationController
    before_action :authenticate_user!

    layout -> { turbo_frame_request? ? false : 'admin/application' }
  end
end
