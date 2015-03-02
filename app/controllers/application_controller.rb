class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
	def current_worker
		@current_worker ||= Worker.find(session[:worker_id]) if session[:worker_id]
	end
	helper_method :current_worker

	def authorize
		redirect_to sessions_url, alert: "Not logged in" if current_worker.nil?
	end
end
