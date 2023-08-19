class Roadmap < ApplicationRecord
  multi_tenant :organization

  has_many :editors
  has_many :steps
  has_many :nodes

  def build_nodes_from_json(draw_flow_json)
    RoadmapNodeBuilder.new(self, draw_flow_json).call
  end
end
