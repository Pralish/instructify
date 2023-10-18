class Assessments::Question < ApplicationRecord
  multi_tenant :organization

  belongs_to :assessment, :inverse_of => :questions
  has_many   :answers
end
