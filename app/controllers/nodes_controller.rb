# frozen_string_literal: true

class NodesController < ApplicationController
  before_action :find_roadmap
  before_action :find_node

  def show; end

  private

  def find_node
    @node = @roadmap.nodes.find(params[:id])
  end

  def find_roadmap
    @roadmap = Roadmap.friendly.find(params[:roadmap_id])
  end
end
