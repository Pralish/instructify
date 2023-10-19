# frozen_string_literal: true

module Assessments
  class AnswersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_attempt!
    before_action :find_question!
    before_action :find_or_initialize_answer

    def create
      @answer.update(answer_params)
    end

    private

    def find_attempt!
      @attempt = current_user.assessment_attempts.find(params[:attempt_id])
    end

    def find_question!
      @question = @attempt.assessment.questions.find(params[:question_id])
    end

    def find_or_initialize_answer
      @answer = @attempt.answers.find_or_initialize_by(question: @question)
    end

    def answer_params
      params.require(:answer).permit(:content)
    end
  end
end
