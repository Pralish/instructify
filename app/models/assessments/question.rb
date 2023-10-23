# frozen_string_literal: true

module Assessments
  class Question < ApplicationRecord
    multi_tenant :organization

    belongs_to :assessment, inverse_of: :questions
    has_many   :answers

    def self.pretty_name
      name.split('::').last.underscore.humanize
    end
  end
end
