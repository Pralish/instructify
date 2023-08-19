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
  end

  def build_nodes
    RoadmapNodeBuilder.new(@roadmap, params[:nodes].as_json).call
  end

  private

  def set_roadmap
    @roadmap = Roadmap.find(params[:id])
  end

  def roadmap_nodes_params
    params.require(:nodes).permit(
      :id,
      :pos_x,
      :pos_y,
      :class,
      data: [:content_type, :content_id, :title],
      inputs: [connections: [:input, :node]],
      outputs: [connections: [:output, :node]]
    )
  end
end
