# frozen_string_literal: true

class RoadmapsController < ApplicationController
  before_action :find_roadmap

  # GET /roadmaps/1 or /roadmaps/1.json
  def show; end

  private

  def find_roadmap
    @roadmap = Roadmap.friendly.find(params[:id])
  end
end
