# frozen_string_literal: true

module Assessments
  class AttemptsController < ApplicationController
    before_action :authenticate_user!, except: :new
    before_action :find_assessment!, only: %i[new create]
    before_action :find_attempt!, only: %i[show submit]

    def new
      return unless user_signed_in?

      @attempt = @assessment.attempts.new(user: current_user)
    end

    def create
      @attempt = @assessment.attempts.new(attempt_params.merge(user_id: current_user.id))
      if @attempt.save
        redirect_to assessments_attempt_path(@attempt), notice: 'Assessment Started'
      else
        render :new
      end
    end

    def show; end

    def submit
      @attempt.submit
    end

    private

    def attempt_params
      params.require(:attempt).permit(:assessment_id)
    end

    def find_assessment!
      @assessment = Assessments::Assessment.find(params[:assessment_id])
    end

    def find_attempt!
      @attempt = current_user.assessment_attempts.find_by!(id: params[:id])
    end
  end
end
