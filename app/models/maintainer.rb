class Maintainer < ApplicationRecord
  multi_tenant :organization

  belongs_to :user
  belongs_to :roadmap

  delegate :first_name, :last_name, :email, to: :user
end
