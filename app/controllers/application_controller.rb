class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }


  def authenticate_any!
      if admin_signed_in?
          true
      else
          authenticate_user!
      end
  end

private
	def current_worker
		@current_worker ||= Worker.find(session[:worker_id]) if session[:worker_id]
	end
	helper_method :current_worker

	def authorize
		redirect_to sessions_url, alert: "Not logged in" if current_worker.nil?
	end
end
