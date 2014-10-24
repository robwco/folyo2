json.array!(@leads) do |lead|
  json.extract! lead, :id, :photo, :title, :url, :name, :email, :website, :twitter, :linkedin, :budget, :notes
  json.url lead_url(lead, format: :json)
end
