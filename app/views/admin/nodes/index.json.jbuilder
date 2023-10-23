# frozen_string_literal: true

json.data do
  json.nodes @nodes do |node|
    json.extract! node, :id, :position
  end

  json.edges @edges do |edge|
    json.id edge.id
    json.type 'stepNode'
    json.source edge.source_id
    json.target edge.target_id
  end
end
