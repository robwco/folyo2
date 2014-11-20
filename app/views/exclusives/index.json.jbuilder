json.array!(@exclusives) do |exclusive|
  json.extract! exclusive, :id, :title, :url, :name, :email, :website, :twitter, :linkedin, :budget, :type, :description, :notes
  json.url exclusive_url(exclusive, format: :json)
end
