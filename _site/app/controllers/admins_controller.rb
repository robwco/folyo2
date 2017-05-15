class AdminsController < ApplicationController
	before_filter :authenticate_admin!
  
	def welcome
    @users = User.all
    @review_projects = Project.includes(:categories, :replies, :user, :listing_package).under_review.page(params[:page]).order(created_at: :desc)
    @projects = Project.includes(:categories, :replies, :user, :listing_package).all.page(params[:page]).order(created_at: :desc)
    @announcement = Announcement.new
    @announcements = Announcement.all
	end

end
