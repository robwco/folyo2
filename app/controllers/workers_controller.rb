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
    if params[:search]
      @leads = Lead.where("category ILIKE '%#{params[:search]}%' OR name ILIKE '%#{params[:search]}%' OR title ILIKE '%#{params[:search]}%'")
      @search_name = params[:search]
    else
      @leads = Lead.all
    end
    
  end

  private

	def worker_params
  	params.require(:worker).permit(:email, :password, :password_confirmation)
  end
end
