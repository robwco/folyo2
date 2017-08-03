class AdminsController < ApplicationController
	before_filter :authenticate_admin!
  
	def welcome
    @users = User.all
    @review_projects = Project.includes(:categories, :replies, :user, :listing_package).under_review.page(params[:page]).order(created_at: :desc)
    @projects = Project.includes(:categories, :replies, :user, :listing_package).all.page(params[:page]).order(created_at: :desc)
    @announcement = Announcement.new
    @announcements = Announcement.all
	end
	
  def download_all    
    respond_to do |format|
      format.csv do 
        payload = CsvExporter.export_users
        send_data payload, type: "application/csv", filename: "all_users.csv"
      end
    end
  end

end
