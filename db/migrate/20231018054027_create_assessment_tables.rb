class CreateAssessmentTables < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments_assessments do |t|
      t.references :organization, null: false, foreign_key: true
      t.string  :name
      t.timestamps
    end

    create_table :assessments_questions do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :assessment, null: false, foreign_key: { to_table: 'assessments_assessments' }
      t.string  :type
      t.string  :question_text
      t.string  :default_text
      t.string  :placeholder
      t.integer :position
      t.text :answer_options
      t.text :validation_rules

      t.timestamps
    end

    create_table :assessments_attempts do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :assessment, null: false, foreign_key: { to_table: 'assessments_assessments' }
      t.references :user

      t.timestamps
    end

    create_table :assessments_answers do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :attempt, null: false, foreign_key: { to_table: 'assessments_attempts' }
      t.references :question, null: false, foreign_key: { to_table: 'assessments_questions' }
      t.text :answer_text

      t.timestamps
    end
  end
end
