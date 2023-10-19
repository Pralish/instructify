# frozen_string_literal: true

module Assessments
  class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_attempt!
    helper_method :pagy_url_for

    def index
      @pagy, @questions = pagy(
        @attempt.questions,
        size: [],
        page_param: :index,
        page: params[:index] || 1,
        items: params[:index].present? ? 1 : 1000
      )
    end

    private

    def pagy_url_for(pagy, page, absolute: false, html_escaped: false)
      params = request.query_parameters.merge(pagy.vars[:page_param] => page, only_path: !absolute)
      html_escaped ? url_for(params).gsub('&', '&amp;') : url_for(params)
    end

    def find_attempt!
      @attempt = current_user.assessment_attempts.find(params[:attempt_id])
    end
  end
end
