# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Organization.find_or_create_by!(name: 'Instructify', subdomain: 'instructify')

User.first_or_create!(email: 'john@instructify.com', first_name: 'John', last_name: 'Doe', password: 'changeme')

MultiTenant.with(Organization.first) do
  roadmap = Roadmap.find_or_create_by!(title: 'Frontend Developer')

  step_1 = roadmap.nodes.create(type: 'Step', title: 'Html')
  step_2 = roadmap.nodes.create(type: 'Step', title: 'Css', parent: step_1)
  step_3 = roadmap.nodes.create(type: 'Step', title: 'javascript', parent: step_2)

  roadmap.nodes.create(
    type: 'Checkpoint',
    title: 'Test',
    parent: step_3,
    assessment_attributes: {
      questions_attributes: [
        { content: 'What is HTML?' },
        { content: 'What is CSS?' },
        { content: 'What is Javascript?' }
      ]
    }
  )
end
