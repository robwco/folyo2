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

  def new_reply(reply)
    @project_owner = reply.project.user
    @freelancer = reply.user
    @reply = reply
    @project = reply.project

    subject = "There's a new reply to your Folyo project!"
    
    mail(to: @project_owner.email, subject: subject, from: "\"Robert Williams (from Folyo)\" <robert@folyo.com>")
  end

  def new_message(message)
    @to_user = User.find(message.to_user_id)
    @from_user = message.user
    @message = message
    @project = message.project

    subject = "There's a new message for you!"

    mail(to: @to_user.email, subject: subject, from: "\"Robert Williams (from Folyo)\" <robert@folyo.com>")
  end
end
