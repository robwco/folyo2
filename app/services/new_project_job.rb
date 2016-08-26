class NewProjectJob < Struct.new(:project_id)
  def perform
    project = Project.find project_id

    User.joins(:categories).active.freelancers.where(categories: { id: project.category_ids }).each do |user|
      ProjectMailer.delay.new_project(user, project)
    end
  end
end
