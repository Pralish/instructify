class Maintainer < ApplicationRecord
  multi_tenant :organization

  belongs_to :user
  belongs_to :roadmap
end
