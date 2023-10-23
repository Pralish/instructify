# frozen_string_literal: true

module Admin
  module Assessments
    class QuestionsController < Admin::ApplicationController
      before_action :find_assessment!
      before_action :find_question!, only: %i[edit update destroy]

      def index
        @questions = @assessment.questions
      end

      def new
        @question = @assessment.questions.build(type: params[:type])
      end

      def edit; end

      def create
        @question = @assessment.questions.build(question_params)
        respond_to do |format|
          if @question.save
            format.turbo_stream
            format.html { redirect_to assessments_questions_path, notice: 'Question Added' }
          end
        end
      end

      def update
        respond_to do |format|
          if @question.update(question_params)
            format.turbo_stream
            format.html { redirect_to assessments_questions_path, notice: 'Question Added' }
          end
        end
      end

      def destroy
        respond_to do |format|
          if @question.destroy
            format.turbo_stream
            format.html { redirect_to assessments_questions_path, notice: 'Question Rermoved' }
          end
        end
      end

      private

      def question_params
        params.require(:question).permit(:type, :content, :correct_answer,
                                         answer_options_attributes: %i[index value _destroy])
      end

      def find_question!
        @question = @assessment.questions.find(params[:id])
      end

      def find_assessment!
        @assessment = Assessments::Assessment.find(params[:assessment_id])
      end
    end
  end
end
