# frozen_string_literal: true

module Assessments
  class Answer < ApplicationRecord
    multi_tenant :organization

    belongs_to :question
    belongs_to :attempt, inverse_of: :answers
  end
end
