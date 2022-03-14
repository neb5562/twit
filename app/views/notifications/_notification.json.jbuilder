json.extract! notification, :id, :seen, :type, :user_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
