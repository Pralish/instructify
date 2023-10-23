# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Organization.find_or_create_by!(name: 'Instructify', subdomain: 'instructify')

User.first_or_create!(email: 'john@instructify.com', first_name: 'John', last_name: 'Doe', password: 'changeme')

MultiTenant.with(Organization.first) do
  roadmap = Roadmap.find_or_create_by!(title: 'Frontend Developer')

  step_1 = roadmap.nodes.create(type: 'Step', title: 'Html')
  step_2 = roadmap.nodes.create(type: 'Step', title: 'Css', parent: step_1)
  roadmap.nodes.create(type: 'Step', title: 'javascript', parent: step_2)

  Task.create!(
    title: 'Learn the Basics',
    roadmap: roadmap,
    parent_id: step_1.id,
    incoming_edges_attributes: [{
      source_handle: 'right',
      target_handle: 'left',
      source: step_1,
      type: ''
    }]
  )

  Task.create!(
    title: 'Writing Semantic HTML',
    roadmap: roadmap,
    parent_id: step_1.id,
    incoming_edges_attributes: [{
      source_handle: 'right',
      target_handle: 'left',
      source: step_1
    }]
  )
end
