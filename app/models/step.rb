class Step < ApplicationRecord
  multi_tenant :organization

  has_ancestry

  belongs_to :roadmap

  has_many :tasks, dependent: :destroy

  accepts_nested_attributes_for :tasks

  after_initialize :set_roadmap_id, if: -> { new_record? && roadmap_id.nil? }

  private

  def set_roadmap_id
    self.roadmap_id = parent.roadmap_id
  end
end
