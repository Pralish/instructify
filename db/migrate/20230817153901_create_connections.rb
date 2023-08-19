class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :from_node, foreign_key: { to_table: :nodes }, null: false, index: true
      t.references :to_node, foreign_key: { to_table: :nodes }, null: false, index: true
      t.string :from_output
      t.string :to_input

      t.timestamps
    end
  end
end
