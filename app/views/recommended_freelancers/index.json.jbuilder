json.array!(@recommended_freelancers) do |recommended_freelancer|
  json.extract! recommended_freelancer, :id, :name, :title, :description, :price, :email
  json.url recommended_freelancer_url(recommended_freelancer, format: :json)
end
