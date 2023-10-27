# frozen_string_literal: true

class Roadmap < ApplicationRecord
  extend FriendlyId
  multi_tenant :organization

  friendly_id :title, use: :slugged

  has_many :maintainers, dependent: :destroy
  has_many :nodes,       dependent: :destroy
  has_one  :creator, -> { where(is_creator: true) }, class_name: 'Maintainer'

  validates :title, presence: true

  accepts_nested_attributes_for :nodes

  after_create :create_first_node, if: -> { nodes.empty? }

  def steps
    nodes.where(type: 'Step')
  end

  def edges
    Edge.joins(%i[source target]).where(nodes: { roadmap_id: id })
  end

  def height
    nodes.reduce(0) { |max_y, node| [max_y, node.position['y'].to_i].max }
  end

  def create_first_node
    nodes.create(type: 'Step', title: 'Step 1')
  end
end
