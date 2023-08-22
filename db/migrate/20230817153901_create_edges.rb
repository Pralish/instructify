class CreateEdges < ActiveRecord::Migration[7.0]
  def change
    create_table :edges do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :source, foreign_key: { to_table: :nodes }, null: false, index: true
      t.references :target, foreign_key: { to_table: :nodes }, null: false, index: true
      t.string :source_handle
      t.string :target_handle
      t.string :label
      t.string :type

      t.timestamps
    end
  end
end
