class Admin::RoadmapsController < Admin::ApplicationController
  before_action :set_roadmap, only: %i[show build_nodes update edit]

  def edit
  end

  # GET /admin/roadmaps
  def index
    @pagy, @roadmaps = pagy(Roadmap.all, items: 10)
  end

  # GET /admin/roadmaps/1 or # GET /admin/roadmaps/1.json
  def show
  end

  def update
    @roadmap.update!(roadmap_params)
  end

  def build_nodes
    RoadmapNodeBuilder.new(@roadmap, params[:nodes].as_json).call
  end

  private

  def set_roadmap
    @roadmap = Roadmap.find(params[:id])
  end

  def roadmap_params
    params.require(:roadmap).permit(
      :id,
      :title,
      nodes_attributes: [
        :id,
        :title,
        :description,
        :type,
        :parent_id,
        position: [:x, :y],
        incoming_edges_attributes: [
          :id,
          :source_id,
          :target_id,
          :label
        ]
      ]
    )
  end
end
