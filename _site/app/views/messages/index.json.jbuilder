json.array!(@messages) do |message|
  json.extract! message, :id, :message, :user_id, :reply_id, :project_id
  json.url message_url(message, format: :json)
end
