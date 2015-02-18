json.array!(@rfps) do |rfp|
  json.extract! rfp, :id, :name
  json.url rfp_url(rfp, format: :json)
end
