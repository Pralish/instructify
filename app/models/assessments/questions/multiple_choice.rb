# frozen_string_literal: true

module Assessments
  module Questions
    class MultipleChoice < Assessments::Question
      acts_as_has_many :answer_options, class_name: 'Assessments::AnswerOption'
      acts_as_accepts_nested_attributes_for :answer_options
    end
  end
end
