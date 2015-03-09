class SessionsController < ApplicationController
  def new
  end
  def create
    worker = Worker.find_by_email(params[:email])
    if worker && worker.authenticate(params[:password])
      session[:worker_id] = worker.id
      redirect_to "work", notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
