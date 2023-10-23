# frozen_string_literal: true

module Student
  class RoadmapsController < Student::ApplicationController
    before_action :set_roadmap

    # GET /student/roadmaps
    def index; end

    # GET /student/roadmaps/1 or # GET /student/roadmaps/1.json
    def show; end

    private

    def set_roadmap
      @roadmap = Roadmap.find(params[:id])
    end
  end
end
