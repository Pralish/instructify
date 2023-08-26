class CreateRoadmaps < ActiveRecord::Migration[7.0]
  def change
    create_table :roadmaps do |t|
      t.string :title
      t.text :description
      t.references :organization, null: false, foreign_key: true
      t.string :slug, null: false
    
      t.timestamps
    end

    add_index :roadmaps, :slug, unique: true
  end
end
