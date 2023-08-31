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
        @roadmap.maintainers.create(user: current_user, is_creator: true)
        format.html { redirect_to edit_admin_roadmap_path(@roadmap), notice: "Roadmap was successfully created." }
        format.json { render :show, status: :created }
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
    respond_to do |format|
      if @roadmap.destroy
        format.html { redirect_to admin_roadmaps_path, notice: 'Roadmap deleted successfully' }
        format.json { render json: '', status: 204 }
      else
        format.html { redirect_back fallback_location: admin_roadmaps_path, alert: @roadmap.errors.full_messages}
        format.json { render json: @roadmap.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_roadmap
    @roadmap = Roadmap.friendly.find(params[:id])
  end

  def roadmap_params
    params.require(:roadmap).permit(
      :id,
      :title,
      :description,
      nodes_attributes: [
        :id,
        :title,
        :description,
        :type,
        :parent_id,
        :blog_image,
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
