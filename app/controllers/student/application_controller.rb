# frozen_string_literal: true

module Student
  class ApplicationController < ApplicationController
    before_action :authenticate_user!

    layout 'student/application'
  end
end
