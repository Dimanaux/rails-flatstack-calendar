json.extract! event, :id, :title, :description, :account_id, :created_at, :updated_at
json.url event_url(event, format: :json)
