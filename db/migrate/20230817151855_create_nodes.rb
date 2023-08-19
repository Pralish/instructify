class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :nodes do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :roadmap, null: false, foreign_key: true
      t.references :content, polymorphic: true,  null: false, index: true
      t.string :pos_x
      t.string :pos_y
      t.string :class_name
      t.boolean :typenode, default: false

      t.timestamps
    end
  end
end
