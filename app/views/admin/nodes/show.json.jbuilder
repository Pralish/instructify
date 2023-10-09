json.data do
  json.node do
    json.id @node.id.to_s
    json.type @node.type
    json.position @node.position
    json.data do
      json.extract! @node, :id, :title, :parent_id, :roadmap_id
      json.has_children @node.children.present?
    end
  end

  json.edge do
    if @node.incoming_edges.present?
      json.id @node.incoming_edges.last&.id
      json.source @node.incoming_edges.last.source_id.to_s
      json.target @node.incoming_edges.last.target_id.to_s
      json.type 'step'
    end
  end
end