class Admin::NodesController < Admin::ApplicationController
  before_action :set_roadmap
  before_action :set_node, only: %i[edit update destroy show]

  # GET /admin/roadmaps/:roadmap_id/nodes
  def index
    @nodes = @roadmap.nodes
    @edges = @roadmap.edges
  end

  def new
    @node = @roadmap.nodes.new(type: 'Step', parent_id: params[:parent_id], child_id: params[:child_id])
  end

  def edit
  render :new
  end

  def show
  end

  def create
    @node = @roadmap.nodes.new(node_params)

    respond_to do |format|
      if @node.save
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "Step was successfully created." }
        format.json { render :show, status: :created }
        format.turbo_stream { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @node.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "@step was successfully created." }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @node.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @node.destroy
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "Deleted successfully" }
        format.json { render json: :no_content }
      else
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "Failed to delete", status: :unprocessable_entity }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_roadmap
    @roadmap = Roadmap.friendly.find(params[:roadmap_id])
  end

  def set_node
    @node = Node.find(params[:id])
  end

  def node_params
    required_param = [:step, :task].find { |param| params.key?(param) } || :node

    params.require(required_param).permit(
      :id,
      :title,
      :content,
      :type,
      :parent_id,
      :child_id,
      position: [:x, :y],
      incoming_edges_attributes: [
        :id,
        :source_id,
        :target_id,
        :source_handle,
        :target_handle,
        :label
      ]
    )
  end
end