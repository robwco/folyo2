json.array!(@projects) do |project|
  json.extract! project, :id, :title, :category, :goals, :examples, :deadline, :budget, :deliverables, :name, :email, :organization, :website
  json.url project_url(project, format: :json)
end
