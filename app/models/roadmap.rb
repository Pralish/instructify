class Roadmap < ApplicationRecord
  multi_tenant :organization

  has_many :phases
end
