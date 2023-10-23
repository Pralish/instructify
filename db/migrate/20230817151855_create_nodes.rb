# frozen_string_literal: true

class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :nodes do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :roadmap, null: false, foreign_key: true
      t.string :type
      t.jsonb :position, default: {}
      t.string :title
      t.string :ancestry

      t.timestamps
    end
  end
end
