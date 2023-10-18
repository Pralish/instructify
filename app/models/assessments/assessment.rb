class Assessments::Assessment < ApplicationRecord
  multi_tenant :organization

  has_many :attempts
  has_many :questions
end