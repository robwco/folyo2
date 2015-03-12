class WorkerMailer < ActionMailer::Base
  default :from => "robert@letsworkshop.com"
  
  def welcome_email(worker)
    @worker = worker
    mail(to: @worker.email, :subject => ":)")
  end
end
