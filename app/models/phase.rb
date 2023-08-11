class Phase < ApplicationRecord
  multi_tenant :organization

  belongs_to :roadmap
  has_many :tasks

  accepts_nested_attributes_for :tasks
end
