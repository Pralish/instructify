class Task < ApplicationRecord
  multi_tenant :organization
  has_ancestry

  belongs_to :phase
end
