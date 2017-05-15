class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }
  before_action :set_unread_message_count


  def authenticate_any!
      if admin_signed_in?
          true
      else
          authenticate_user!
      end
  end

  def after_sign_in_path_for(resource)
    if session[:unsent_reply_biography]
      return complete_replies_path
    end
    stored_location_for(resource) || root_path
  end

private
	def current_worker
		@current_worker ||= Worker.find(session[:worker_id]) if session[:worker_id]
	end
	helper_method :current_worker

	def authorize
		redirect_to sessions_url, alert: "Not logged in" if current_worker.nil?
	end

  def set_unread_message_count
    @unread_message_count = 0
    if user_signed_in?
      @unread_message_count = (Message.sent_to(current_user).unread.count + Reply.replied_to(current_user).unread.count) || 0
    end
  end
end
