json.links do
  json.self roadmap_url(@roadmap, format: :json)
end

json.data do
  json.type 'roadmaps'
  json.id @roadmap.id
  json.attributes do
    json.extract! @roadmap, :id, :title, :description

    json.set! :steps do
      @roadmap.steps.each do |step|
        json.set! step.id.to_s do
          json.id step.id.to_s
          json.set! :data do
            json.merge! Hash.new
          end
          json.class ""
          json.name step.title
          json.html render(partial: 'roadmaps/step', locals: { step: step }, formats: [:html]).html_safe
          json.typenode false
          json.set! :inputs do
            if step.parent_id
              json.set! "input_1" do
                json.connections [{ node: step.parent_id.to_s, input: "output_1"}] 
              end
            else
              json.merge! Hash.new
            end
          end
          json.set! :outputs do
            if step.children.present?
              json.set! "output_1" do
                json.connections step.children.each do |child|
                  json.node child.id.to_s
                  json.output "input_1"
                end
              end
            else
              json.merge! Hash.new
            end
          end

          json.pos_x 0
          json.pos_y step.ancestors.count * 100
        end
      end
    end
  end
end


        