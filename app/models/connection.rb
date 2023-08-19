class Connection < ApplicationRecord
  multi_tenant :organization

  belongs_to :from_node, class_name: 'Node', foreign_key: 'from_node_id'
  belongs_to :to_node, class_name: 'Node', foreign_key: 'to_node_id'
end
