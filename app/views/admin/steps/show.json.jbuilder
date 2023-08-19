json.data do
  json.type 'steps'
  json.id @step.id
  json.attributes do
    json.extract! @step, :id, :title, :description

    json.node do
      json.partial! 'shared/nodes/node', node: @step.node
    end
  end
end
