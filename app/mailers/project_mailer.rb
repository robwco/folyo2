class ProjectMailer < ActionMailer::Base
  default :from => "robert@letsworkshop.com"
  helper ApplicationHelper
  helper UsersHelper

  def new_project(freelancer, project)
	  subject = "There's a new Folyo project! #{project.title}"

    @user = freelancer
    @project = project
	  
	  mail(to: freelancer.email, subject: subject, from: "\"Robert Williams (from Folyo)\" <robert@folyo.com>")
  end
end
