json.array!(@replies) do |reply|
  json.extract! reply, :id, :message, :user_id, :portfolio_message, :project_id
  json.url reply_url(reply, format: :json)
end
