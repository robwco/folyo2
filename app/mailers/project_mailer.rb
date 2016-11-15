class ProjectMailer < ActionMailer::Base
  include UsersHelper
  default :from => "hello@folyo.me"
  helper ApplicationHelper
  helper :users

  def new_project(freelancer, project)
	  subject = "[Folyo] #{project.user.company_name} - #{project.title}"

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

  def client_approval(project)
    @user = project.user
    @project = project
    @token = @user.authentication_token 

    subject = "RE: #{first_name @user.name} have you found a freelancer yet?"

    mail(to: @user.email, subject: subject, from: "\"Robert Williams\" <robert@folyo.me>")
  end

  def welcome(user)
    @user = user

    subject = "Welcome to Folyo!"

    mail(to: user.email, subject: subject, from: "\"Rob Williams\" <robert@folyo.me>")
  end
end
