# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

organization = Organization.find_or_create_by!(name: 'Instructify', subdomain: 'instructify')

user = User.first_or_create!(email: 'john@instructify.com', first_name: 'John', last_name: 'Doe', password: 'changeme')

MultiTenant.with(organization) do
  Member.find_or_create_by!(user: user)

  roadmap = Roadmap.find_or_create_by!(title: 'Frontend Developer')
  step_1 = roadmap.steps.find_or_create_by!(title: 'Html')
  step_2 = step_1.children.find_or_create_by!(title: 'CSS')
  step_3 = step_2.children.find_or_create_by!(title: 'JavaScript')
end

