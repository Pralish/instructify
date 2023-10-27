# frozen_string_literal: true

module Assessments
  class Attempt < ApplicationRecord
    multi_tenant :organization

    belongs_to :assessment
    belongs_to :user

    has_many   :questions, through: :assessment
    has_many   :answers, inverse_of: :attempt, autosave: true

    def submit
      update(submitted_at: Time.zone.now)
    end

    def submitted?
      submitted_at.present?
    end
  end
end
