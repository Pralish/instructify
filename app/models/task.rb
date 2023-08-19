class Task < ApplicationRecord
  multi_tenant :organization

  has_ancestry

  has_one :node, as: :content, dependent: :destroy

  accepts_nested_attributes_for :node
end
