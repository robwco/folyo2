class SessionsController < ApplicationController
  def new
  end

  def create
  	worker = Worker.find_by_email(params[:email])
  	if worker && worker.authenticate(params[:password])
  		session[:worker_id] = worker.id
  		redirect_to work_url
  	else
  		flash.now.alert = "Wrong email or password"
  		render "new"
  	end
  end

  def destroy
    session[:worker_id] = nil
    redirect_to login_url, notice: "You're logged out"
  end


end