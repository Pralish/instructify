class Edge < ApplicationRecord
  multi_tenant :organization

  belongs_to :source, class_name: 'Node', foreign_key: 'source_id'
  belongs_to :target, class_name: 'Node', foreign_key: 'target_id', inverse_of: :incoming_edges
end
