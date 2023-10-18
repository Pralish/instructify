class Assessments::Answer < ApplicationRecord
  multi_tenant :organization

  belongs_to :question
  belongs_to :attempt, inverse_of: :answers
end
