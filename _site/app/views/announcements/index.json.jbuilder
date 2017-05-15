json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :subject, :message
  json.url announcement_url(announcement, format: :json)
end
