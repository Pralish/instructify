class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :step, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :ancestry

      t.timestamps
    end

    add_index :tasks, :ancestry
  end
end
