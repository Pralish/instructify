# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string     :invitation_token, index: { unique: true }
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invited_by_id
      t.jsonb      :roles, default: ['demo']

      t.timestamps
    end
  end
end
