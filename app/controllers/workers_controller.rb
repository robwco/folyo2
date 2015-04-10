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
    if params[:category].blank?
      @leads = Lead.most_recent.limit(7).all
      @exclusives = Exclusive.all
      @categories = Category.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @leads = Lead.where(category_id: @category_id).all
      @exclusives = Exclusive.all
      @categories = Category.category_id.all
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
