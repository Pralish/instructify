# frozen_string_literal: true

class CreateAssessmentTables < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments_assessments do |t|
      t.references  :organization,  null: false, foreign_key: true
      t.references  :checkpoint,    null: false, foreign_key: { to_table: 'nodes' }
      t.string      :name
      t.timestamps
    end

    create_table :assessments_questions do |t|
      t.references  :organization,  null: false, foreign_key: true
      t.references  :assessment,    null: false, foreign_key: { to_table: 'assessments_assessments' }
      t.string      :type
      t.string      :content
      t.integer     :position
      t.text        :answer_options

      t.timestamps
    end

    create_table :assessments_attempts do |t|
      t.references  :organization,  null: false, foreign_key: true
      t.references  :assessment,    null: false, foreign_key: { to_table: 'assessments_assessments' }
      t.references  :user
      t.datetime    :submitted_at

      t.timestamps
    end

    create_table :assessments_answers do |t|
      t.references  :organization,  null: false, foreign_key: true
      t.references  :attempt,       null: false, foreign_key: { to_table: 'assessments_attempts' }
      t.references  :question,      null: false, foreign_key: { to_table: 'assessments_questions' }
      t.text        :content

      t.timestamps
    end
  end
end
