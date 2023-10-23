# frozen_string_literal: true

class RoadmapNodeBuilder
  attr_accessor :roadmap, :nodes, edges

  def initialize(roadmap, nodes, edges)
    @roadmap = roadmap
    @nodes = nodes
    @edges = edges
  end

  def call
    build_nodes
    build_connections
  end

  private

  def build_nodes
    # ids of nodes and
    edges = edges.map do |edge|
      edge[:source_id] = nodes.select { |node| node[:id] == edge[:source] }[:data][:id]
      edge[:target_id] = nodes.select { |node| node[:id] == edge[:target] }[:data][:id]
      edge
    end

    nodes = nodes.map do |node|
      node[:id] = node[:data][:id]
    end

    nodes.each do |node_data|
      node = Node.find_by_id(node_data[:data][:id]).update(node_data[:data])

      edges.select { |edge| edge[:source] == node_data[:id] }
      node.incoming_edges.update
      edges.select { |edge| edge[:target] == node_data[:id] }
    end

    edges.each do |edge|
      nodes.select { |node| node.id == edge.source }
    end

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
    draw_flow_export.each_value do |node_data|
      node_data[:inputs].each do |key, value|
        value[:connections].each do |c|
          # TODO: handle multiple parents
          unless node_data[:data][:parent_id]
            node_data[:node].content.update!(parent: draw_flow_export[c[:node].to_s][:node].content)
          end

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
