class ProjectMailer < ActionMailer::Base
  default :from => "hello@folyo.me"
  helper ApplicationHelper
  helper UsersHelper

  def new_project(freelancer, project)
	  subject = "New Folyo project! #{project.title}"

    @user = freelancer
    @project = project
	  
	  mail(to: freelancer.email, subject: subject, from: "\"Folyo\" <hello@folyo.me>")
  end

  def new_reply(reply)
    @project_owner = reply.project.user
    @freelancer = reply.user
    @reply = reply
    @project = reply.project

    subject = "#{@freelancer.name} just replied to your project!"
    
    mail(to: @project_owner.email, subject: subject, from: "\"Folyo\" <hello@folyo.me>")
  end

  def new_message(message)
    @to_user = User.find(message.to_user_id)
    @from_user = message.user
    @message = message
    @project = message.project
    @reply = message.reply

    subject = "#{@from_user.name} just sent you a new message!"

    mail(to: @to_user.email, subject: subject, from: "\"Folyo\" <hello@folyo.me>")
  end

  def welcome(user)
    @user = user

    subject = "Welcome to Folyo!"

    mail(to: user.email, subject: subject, from: "\"Rob Williams\" <robert@folyo.me>")
  end
end
