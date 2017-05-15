json.array!(@offerings) do |offering|
  json.extract! offering, :id, :name, :email, :title, :description, :contact_info, :category
  json.url offering_url(offering, format: :json)
end
