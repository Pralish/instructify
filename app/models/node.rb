class Node < ApplicationRecord
  multi_tenant :organization

  belongs_to :roadmap
  belongs_to :content, polymorphic: true

  has_many :input_connections,  class_name: 'Connection', foreign_key: 'to_node_id',   dependent: :destroy
  has_many :output_connections, class_name: 'Connection', foreign_key: 'from_node_id', dependent: :destroy

  after_create :create_connections, if: -> { input_connections.empty? }

  after_initialize :set_roadmap_id, if: -> { new_record? && roadmap_id.nil? }

  after_initialize :set_position,   if: -> { new_record? && pos_x.nil? && pos_y.nil? }

  def parent
    content.parent&.node
  end

  private
  
  def set_roadmap_id
    self.roadmap_id = content&.roadmap_id
  end

  def create_connections
    input_connections.create!(from_node: parent, from_output: 'output_1', to_input: 'input_1' ) if parent.present?
  end

  def set_position
    self.pos_x = parent.pos_x.to_f
    self.pos_y = parent.pos_y.to_f + 100
  end
end