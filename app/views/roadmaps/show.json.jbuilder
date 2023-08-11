json.extract! @roadmap, :id, :created_at, :updated_at
json.url roadmap_url(@roadmap, format: :json)
