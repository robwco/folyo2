json.array!(@job_sources) do |job_source|
  json.extract! job_source, :id, :name, :url
  json.url job_source_url(job_source, format: :json)
end
