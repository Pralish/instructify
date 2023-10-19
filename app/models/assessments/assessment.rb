# frozen_string_literal: true

module Assessments
  class Assessment < ApplicationRecord
    multi_tenant :organization

    has_many :attempts, dependent: :destroy
    has_many :questions, dependent: :destroy

    belongs_to :checkpoint

    accepts_nested_attributes_for :questions, allow_destroy: true
  end
end
