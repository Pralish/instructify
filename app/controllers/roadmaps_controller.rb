class RoadmapsController < ApplicationController
  before_action :set_roadmap

  # GET /roadmaps/1 or /roadmaps/1.json
  def show
  end

  private

  def set_roadmap
    @roadmap = Roadmap.friendly.find(params[:id])
  end
end
