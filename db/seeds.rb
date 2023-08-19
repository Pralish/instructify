# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

organization = Organization.find_or_create_by!(name: 'Instructify', subdomain: 'instructify')

user = User.first_or_create!(email: 'john@instructify.com', first_name: 'John', last_name: 'Doe', password: 'changeme')

MultiTenant.with(Organization.first) do

  roadmap = Roadmap.find_or_create_by!(title: 'Frontend Developer')

  data = {
    "1": {
        "id": "1",
        "data": { "content_type": "Step", "title": "Html" },
        "class": "",
        "name": "Html",
        "typenode": false,
        "inputs": {},
        "outputs": {
            "output_1": {
                "connections": [
                    {
                        "node": "2",
                        "output": "input_1"
                    }
                ]
            }
        },
        "pos_x": 0,
        "pos_y": 0
    },
    "2": {
        "id": "2",
        "data": { "content_type": "Step", "title": "Css" },
        "class": "",
        "name": "CSS",
        "typenode": false,
        "inputs": {
            "input_1": {
                "connections": [
                    {
                        "node": "1",
                        "input": "output_1"
                    }
                ]
            }
        },
        "outputs": {
            "output_1": {
                "connections": [
                    {
                        "node": "4",
                        "output": "input_1"
                    }
                ]
            }
        },
        "pos_x": 0,
        "pos_y": 100
    },
    "4": {
        "id": "4",
        "data": { "content_type": "Step", "title": "Javascript" },
        "class": "",
        "name": "JS",
        "typenode": false,
        "inputs": {
            "input_1": {
                "connections": [
                    {
                        "node": "2",
                        "input": "output_1"
                    }
                ]
            }
        },
        "outputs": {},
        "pos_x": 0,
        "pos_y": 200
    }
  }

  RoadmapNodeBuilder.new(roadmap, data).call
end



