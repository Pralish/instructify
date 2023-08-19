
class RoadmapNodeBuilder
  attr_accessor :roadmap, :draw_flow_export

  def initialize(roadmap, draw_flow_export)
    @roadmap = roadmap
    @draw_flow_export = draw_flow_export.with_indifferent_access
  end

  def call
    build_nodes
    build_connections
  end

  private

  def build_nodes
    draw_flow_export.transform_values! do |node_data|
      content = node_data[:data][:content_type].constantize.where(id: node_data[:data][:content_id]).first_or_initialize
      content.update!(
        title: node_data[:data][:title],
        roadmap_id: roadmap.id,
        node_attributes: {
          id: content.node&.id,
          pos_x: node_data[:pos_x],
          pos_y: node_data[:pos_y],
          class_name: node_data[:class],
          roadmap_id: roadmap.id
        }
      )
      node_data[:node] = content.node
      node_data
    end
  end

  def build_connections
    draw_flow_export.values.each do |node_data|
      node_data[:inputs].each do |key, value|
        value[:connections].each do |c|
          # TODO: handle multiple parents
          node_data[:node].content.update!(parent: draw_flow_export[c[:node].to_s][:node].content) unless node_data[:data][:parent_id]
    
          Connection.where(from_node: draw_flow_export[c[:node].to_s][:node], to_node: node_data[:node])
            .first_or_initialize
            .update!(
              from_output: c[:input],
              to_input: key
            )
        end
      end
    end
  end
end