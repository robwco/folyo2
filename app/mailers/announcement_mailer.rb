class AnnouncementMailer < ActionMailer::Base
  default from: "hello@folyo.me"
  helper ApplicationHelper
  helper UsersHelper
  
  def new_announcement(user, announcement)
	  subject = "#{announcement.subject}"

    @user = user
    @announcement = announcement
	  
	  mail(to: user.email, subject: subject, from: "\"Robert Williams\" <hello@folyo.me>")
  end
end
