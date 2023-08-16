class Admin::RoadmapsController < Admin::ApplicationController
  before_action :set_roadmap

  # GET /admin/roadmaps
  def index
  end

  # GET /admin/roadmaps/1 or # GET /admin/roadmaps/1.json
  def show
  end

  private

  def set_roadmap
    @roadmap = Roadmap.find(params[:id])
  end
end
