class WorkersController < ApplicationController
	def new
		@worker = Worker.new
	end

  def create
    @worker = Worker.new(worker_params)
	  if @worker.save
	    session[:worker_id] = @worker.id
	    redirect_to onboard_url
	  else
	    render "work"
	  end
  end

  def work
  	if current_worker.nil?
  		redirect_to login_url, alert: "You gotta log in!"
  	end
    @leads = Lead.all
    @exclusives = Exclusive.all
  end

  private

	def worker_params
  	params.require(:worker).permit(:email, :password, :password_confirmation)
  end
end
