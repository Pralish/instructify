class Member < ApplicationRecord
  multi_tenant :organization

  belongs_to :organization
  belongs_to :user
end
