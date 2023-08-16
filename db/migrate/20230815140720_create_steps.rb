class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.string :title
      t.text :description
      t.references :roadmap, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :ancestry

      t.timestamps
    end

    add_index :steps, :ancestry
  end
end
