json.links do
  json.self roadmap_url(@roadmap, format: :json)
end

json.data do
  json.type 'roadmaps'
  json.id @roadmap.id
  json.attributes do
    json.extract! @roadmap, :id, :title, :description

    json.set! :nodes do
      @roadmap.nodes.each do |node|
        json.set! node.id do
          json.partial! 'shared/nodes/node', node: node
        end
      end
    end
  end
end


        