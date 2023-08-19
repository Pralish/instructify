class Step < ApplicationRecord
  multi_tenant :organization

  has_ancestry

  belongs_to :roadmap

  has_many :tasks, dependent: :destroy

  has_one :node, as: :content, dependent: :destroy

  accepts_nested_attributes_for :tasks

  accepts_nested_attributes_for :node

  after_initialize :set_roadmap_id, if: -> { new_record? && roadmap_id.nil? }

  after_create :create_node, if: -> { node.nil? }

  def next_step 
    children.first
  end

  private

  def set_roadmap_id
    self.roadmap_id = parent&.roadmap_id
  end
end
