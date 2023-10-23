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
      @attempt = @assessment.attempts.new(user: current_user)

      if @attempt.save
        redirect_to assessments_attempt_questions_path(attempt_id: @attempt), notice: 'Assessment Started'
      else
        render :new
      end
    end

    def show
      unless @attempt.submitted?
        return redirect_to assessments_attempt_questions_path(attempt_id: @attempt),
                           notice: 'Assessment not completed'
      end

      @answers = @attempt.answers
    end

    def submit
      return unless @attempt.submit

      redirect_to assessments_attempt_path(@attempt), notice: 'Assessment Submitted'
    end

    private

    def find_assessment!
      @assessment = Assessments::Assessment.find(params[:assessment_id])
    end

    def find_attempt!
      @attempt = current_user.assessment_attempts.find_by!(id: params[:id])
    end
  end
end
