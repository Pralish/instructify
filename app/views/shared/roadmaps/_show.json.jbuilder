# frozen_string_literal: true

json.links do
  json.self roadmap_url(roadmap, format: :json)
end

json.data do
  json.type 'roadmaps'
  json.id roadmap.id
  json.attributes do
    json.extract! roadmap, :id, :title, :description

    json.nodes roadmap.nodes do |node|
      json.id node.id.to_s
      json.type node.type
      json.data do
        json.extract! node, :id, :title, :parent_id, :roadmap_id
        json.has_children node.children.where(type: 'Step').present?
      end
      json.style node.is_a?(Step) ? roadmap.step_nodes_settings : roadmap.task_nodes_settings
      json.position node.position
    end

    json.edges roadmap.edges do |edge|
      json.id edge.id
      json.source edge.source_id.to_s
      json.target edge.target_id.to_s
      json.sourceHandle edge.source_handle
      json.targetHandle edge.target_handle
      json.style edge.target.type == 'Step' ? roadmap.step_edges_settings : roadmap.task_edges_settings
      json.animated edge.target.type == 'Step' ? roadmap.step_edges_settings&.dig('animated') == '1' : roadmap.task_edges_settings&.dig('animated') == '1'
      json.type edge.target.type == 'Task' ? 'floating' : 'button'
      json.data do
        json.roadmap_id roadmap.id
        json.source_id edge.source_id
        json.target_id edge.target_id
      end
    end
  end
end
