class Task < ApplicationRecord
  multi_tenant :organization

  has_ancestry
end
