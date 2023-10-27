# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Organization.find_or_create_by!(name: 'Instructify', subdomain: 'instructify')

User.first_or_create!(email: 'john@instructify.com', first_name: 'John', last_name: 'Doe', password: 'changeme')

MultiTenant.with(Organization.first) do
  roadmap = Roadmap.find_or_create_by!(title: 'Frontend Developer')

  step_1 = roadmap.nodes.first_or_initialize.tap do |step|
    step.type = 'Step'
    step.title = 'Html'
    step.position = {x: 196, y: 30}
    step.save!
  end
  step_2 = roadmap.nodes.find_or_initialize_by(type: 'Step', title: 'Css').tap do |step|
    step.parent = step_1
    step.position = { x: 353, y: 186 }
    step.save!
  end
  step_3 = roadmap.nodes.find_or_initialize_by(type: 'Step', title: 'javascript').update(
    parent: step_2,
    position: { x: 180, y: 348 },
    assessment_attributes: {
      questions_attributes: [
        { content: 'What is HTML?' },
        { content: 'What is CSS?' },
        { content: 'What is Javascript?' },
        {
          type: 'Assessments::Questions::SingleChoice',
          content: 'Which is correct?',
          answer_options: [
            { index: 1, value: 'This' },
            { index: 2, value: 'That' },
            { index: 3, value: 'Both' },
            { index: 4, value: 'None' }
          ],
          correct_answer: 2
        },
        {
          type: 'Assessments::Questions::MultipleChoice',
          content: 'Select all correct answers.',
          answer_options: [
            { index: 1, value: 'This' },
            { index: 2, value: 'That' },
            { index: 3, value: 'Both' },
            { index: 4, value: 'None' }
          ],
          correct_answer: [1, 2]
        }
      ]
    }
  )
end
