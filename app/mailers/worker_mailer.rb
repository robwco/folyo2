class WorkerMailer < ActionMailer::Base
  default :from => "robert@letsworkshop.com"
  helper ApplicationHelper
  helper UsersHelper
  
  def welcome_email(worker)
    @worker = worker
    mail(to: worker.email, :subject => ":)")
  end

  def requested_leads(user, leads)
	@user = user
	@leads = leads

	mail(to: 'robert@letsworkshop.com', subject: 'A cancelling user requested these types of leads')
  end

  def daily_leads(user)
	  @user = user
	  category_ids = @user.category_ids

	  if category_ids.empty?
		  @leads = Lead.eager_load(:category).most_recent
	  else
		  @leads = Lead.eager_load(:category).most_recent.where("category_id IN (?)", category_ids)
	  end

	  @exclusives = Exclusive.today.most_recently_updated

	  @categories = Category.all
	  @milestones = Milestone.all

	  @milestones_hash = Hash[ @milestones.map{ |m| [m.id, m.description] }]

	  subject = "Latest Gigs #{DateTime.now.strftime('%d %B %Y')}"

	  subject << " **exclusive lead inside**" if @exclusives.count > 0
	  
	  mail(to: user.email, subject: subject, from: "\"Robert Williams (from Workshop)\" <robert@letsworkshop.com>")
  end
end
