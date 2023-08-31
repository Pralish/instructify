class Node < ApplicationRecord
  multi_tenant :organization

  has_ancestry

  has_one_attached :blog_image

  belongs_to :roadmap

  has_many :incoming_edges,  class_name: 'Edge', foreign_key: 'target_id',   dependent: :destroy, inverse_of: :target
  has_many :outgoing_edges, class_name: 'Edge', foreign_key: 'source_id', dependent: :destroy

  after_create :create_edge, if: -> { incoming_edges.empty? && parent.present? }

  after_initialize :set_roadmap_id, if: -> { new_record? && roadmap_id.nil? }

  after_initialize :set_position,   if: -> { new_record? && position.blank? }

  accepts_nested_attributes_for :incoming_edges

  def edges
    incoming_edges.or(outgoing_edges)
  end

  private
  
  def set_roadmap_id
    self.roadmap_id = parent&.roadmap_id
  end

  def create_edge
    Edge.create!(source: parent, target: self, source_handle: 'bottom', target_handle: 'top')
  end

  def set_position
    self.position = {
      x: parent.present? ? parent.position["x"].to_f : 0,
      y: parent.present? ? parent.position["y"].to_f + 150 : 0
    } 
  end
end