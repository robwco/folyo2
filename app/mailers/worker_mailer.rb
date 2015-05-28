class WorkerMailer < ActionMailer::Base
  default :from => "robert@letsworkshop.com"
  
  def welcome_email(worker)
    @worker = worker
    mail(to: worker.email, :subject => ":)")
  end

  def requested_leads(user, leads)
	@user = user
	@leads = leads

	mail(to: 'jaf656s@gmail.com', subject: 'A cancelling user requested these types of leads')
  end
end
