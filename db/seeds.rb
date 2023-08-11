# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

organization = Organization.first_or_create(name: 'Instructify', subdomain: 'instructify')
user = User.first_or_create(email: 'john@instrutify.com', password: 'changeme', first_name: 'John', last_name: 'Doe')

MultiTenant.with(organization) do
  Member.first_or_create(user: user)

  roadmap = Roadmap.first_or_create(title: 'Frontend Developer')
  roadmap.phases.create(
    title: 'Basics',
    tasks_attributes: [ 
      {title: 'HTML'},
      {title: 'CSS'},
      {title: 'Javascript'}
    ])
end

