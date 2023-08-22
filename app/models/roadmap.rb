class Roadmap < ApplicationRecord
  multi_tenant :organization

  has_many :editors
  has_many :nodes

  accepts_nested_attributes_for :nodes

  def edges
    Edge.joins([:source, :target]).where(nodes: {roadmap_id: id})
  end

  def build_nodes_from_json(draw_flow_json)
    RoadmapNodeBuilder.new(self, draw_flow_json).call
  end
end
