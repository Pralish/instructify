# frozen_string_literal: true

json.extract! node, :id, :class, :pos_x, :pos_y, :typenode
json.name "node_#{node.id}"
json.html render(partial: 'roadmaps/step', locals: { step: node.content }, formats: [:html]).html_safe

json.data do
  json.content_type node.content_type
  json.content_id node.content_id
  json.title node.content.title
  json.node_id node.id
  json.parent_node node.parent&.id
end

json.inputs do
  if node.input_connections.present?
    node.input_connections.group_by(&:to_input).each do |key, val|
      json.set! key do
        json.connections(val.map { |v| { node: v.from_node_id, input: v.from_output } })
      end
    end
  else
    json.merge!({})
  end
end

json.outputs do
  if node.output_connections.present?
    node.output_connections.group_by(&:from_output).each do |key, val|
      json.set! key do
        json.connections(val.map { |v| { node: v.to_node_id, output: v.to_input } })
      end
    end
  else
    json.merge!({})
  end
end
