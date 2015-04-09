class WorkersController < ApplicationController
  before_action :authenticate_user!
	def new
		@worker = Worker.new
	end

  def create
    @worker = Worker.new(worker_params)
    @leads = Lead.all
    @exclusives = Exclusive.all
	  if @worker.save
	    WorkerMailer.welcome_email(@worker).deliver
	    session[:worker_id] = @worker.id
	    redirect_to onboard_url, notice: "Thank you for signing up!"
	  else
	    render "work"
	  end
  end
  
  def category
  end
  
  def recent
  end
  
  def index
    @workers = Worker.all
  end
  
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url, notice: 'Worker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def work
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
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == "workshop" && password == "sbGfKA3A9xfd/jB"
    end
  	def worker_params
    	params.require(:worker).permit(:email, :password, :password_confirmation)
    end
  end
end
