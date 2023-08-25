class Admin::RoadmapsController < Admin::ApplicationController
  before_action :set_roadmap, only: %i[show update edit destroy]

  # GET /admin/roadmaps
  def index
    @pagy, @roadmaps = pagy(Roadmap.all, items: 10)
  end

  def new
    @roadmap = Roadmap.new
  end

  def edit
  end

  # GET /admin/roadmaps/1 or # GET /admin/roadmaps/1.json
  def show
  end

  def create
    @roadmap = Roadmap.new(roadmap_params)
    respond_to do |format|
      if @roadmap.save
        @roadmap.editors.create(user: current_user)
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "Step was successfully created." }
        format.json { render :show, status: :created }
        format.turbo_stream { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @roadmap.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def update
    @roadmap.update!(roadmap_params)
  end

  def destroy
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
