# frozen_string_literal: true

module Admin
  module Assessments
    class AssessmentsController < ApplicationController
      def create
        @assessment = Assessments::Assessment.create(assessment_params)

        respond_to do |format|
          if @assessment.save
            format.turbo_stream
            format.html { redirect_to assessments_questions_path(assessment_id: @assessment.id) }
          end
        end
      end

      def assessment_params
        params.require(:assessment).permit(:node_id)
      end
    end
  end
end
