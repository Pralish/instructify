class CreateMaintainer < ActiveRecord::Migration[7.0]
  def change
    create_table :maintainers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.references :roadmap, null: false, foreign_key: true
      t.boolean    :is_creator, default: false

      t.timestamps
    end
  end
end
