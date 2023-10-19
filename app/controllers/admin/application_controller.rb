# frozen_string_literal: true

module Admin
  class ApplicationController < ApplicationController
    layout 'admin/application'

    before_action :authenticate_user!
  end
end
