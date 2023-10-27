# frozen_string_literal: true

module Admin
  class NodesController < Admin::ApplicationController
    before_action :find_roadmap
    before_action :find_node, only: %i[edit update destroy show]

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

    def show; end

    def create
      @node = @roadmap.nodes.new(node_params)

      respond_to do |format|
        if @node.save
          format.html do
            redirect_back fallback_location: roadmap_path(@roadmap), notice: 'Step was successfully created.'
          end
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
          format.html do
            redirect_back fallback_location: roadmap_path(@roadmap), notice: '@step was successfully created.'
          end
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
          format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: 'Deleted successfully' }
          format.json { render json: :no_content }
        else
          format.html do
            redirect_back fallback_location: roadmap_path(@roadmap), notice: 'Failed to delete',
                          status: :unprocessable_entity
          end
          format.json { render json: @node.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def find_roadmap
      @roadmap = Roadmap.friendly.find(params[:roadmap_id])
    end

    def find_node
      @node = Node.find(params[:id])
    end

    def node_params
      params.require(:node).permit(
        :id,
        :title,
        :content,
        :type,
        :parent_id,
        :child_id,
        position: %i[x y],
        incoming_edges_attributes: %i[
          id
          source_id
          target_id
          source_handle
          target_handle
          label
        ],
        assessment_attributes: [
          :id,
          { questions_attributes: %i[
            id
            content
            _destroy
          ] }
        ]
      )
    end
  end
end
