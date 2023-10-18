class Assessments::Attempt < ApplicationRecord
  multi_tenant :organization

  belongs_to :survey
  belongs_to :user

  has_many   :answers, inverse_of: :attempt, autosave: true
end
