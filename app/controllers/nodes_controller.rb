# frozen_string_literal: true

class NodesController < ApplicationController
  before_action :set_roadmap
  before_action :set_node

  def show; end

  private

  def set_node
    @node = @roadmap.nodes.find(params[:id])
  end

  def set_roadmap
    @roadmap = Roadmap.friendly.find(params[:roadmap_id])
  end
end
