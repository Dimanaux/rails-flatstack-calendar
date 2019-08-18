json.extract! event, :id, :title, :description, :datetime, :until, :created_at, :updated_at
json.url event_url(event, format: :json)
