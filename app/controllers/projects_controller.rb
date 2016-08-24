class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]
  before_action :set_project_with_owner, only: [:preview, :payment, :select_payment, :charge_payment, :collect_payment, :edit, :update, :update_status, :thank_you, :destroy]
  before_filter :authenticate_any!, except: [:show, :home, :portal, :tour]

  respond_to :html

  def home
    @projects =  Project.published.page(params[:page]).order(created_at: :desc)
    @projects = @projects.joins(:categories).where({ categories: { id: params[:category_id] } }) if params[:category_id]
  end
  
  def thank_you
  end

  def active
  end

  def yours
  end
  
  def portal
  end

  
  def publish
  end
  
  def inbox
    if params[:archived]
      @messages = Message.sent_to(current_user).read
      @replies = Reply.replied_to(current_user).read
    else
      @messages = Message.sent_to(current_user).unread.limit(10)
      @replies = Reply.replied_to(current_user).unread.limit(10)
    end

    @all_messages = @messages + @replies
    @all_messages.sort_by(&:created_at)
  end
  
  
  def index
    @projects = Project.all
    respond_with(@projects)
  end

  def show
    @reply = @project.reply_from(current_user)
    if @reply.blank?
      @reply = Reply.new
      @reply.biography = current_user.biography if current_user

      if session[:unsent_reply_biography]
        @reply.biography = session[:unsent_reply_biography]
        @reply.message = session[:unsent_reply_message]
        @reply.next_steps = session[:unsent_reply_next_steps]
      end
    end
    @message = Message.new
  end

  def payment
	  @packages = ListingPackage.active.order(:price)
  end

  def select_payment
    unless ListingPackage.active.find(payment_package_params[:listing_package_id])
      redirect_to payment_project_path(@project) 
      return
    end

    respond_to do |format|
      if @project.update(payment_package_params)

		if @project.listing_package.price > 0
			format.html { 
				redirect_to collect_payment_project_path(@project) 
			}
		else
			@project.publish
			format.html { 
				redirect_to @project, notice: "Your project has been posted."
			}
		end
      else
        format.html { redirect_to payment_project_path(@project), notice: "The package you selected was invalid." }
      end
    end

  end

  def collect_payment
  end

  def charge_payment
	  if ChargeProject.call params[:stripeToken], @project
      redirect_to @project, notice: "Your payment was accepted."	
    else
      format.html { render :collect_payment, notice: "Please correct the errors below." }
    end
  end

  def new
    if current_user.present? && current_user.company_name.blank?
      redirect_to client_details_path and return
    end

    @project = Project.new
  end

  def edit
  end

  def create
    #render plain: params.inspect and return
    @project = Project.new(project_params)
    @project.user = current_user
    @project.organization = current_user.company_name
    @project.name = current_user.name
    @project.website = current_user.company_website
    @project.company_logo = current_user.company_logo
    @project.company_description = current_user.company_biography
    @project.published = true

    respond_to do |format|
      if @project.save
        format.html { 
          redirect_to thank_you_project_path(@project), notice: 'Project was successfully created.' 
        }
      else
        flash[:error] = "Please correct the errors below."
        format.html { render :new }
      end
    end
  end

  #def preview
  #end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { 
          redirect_to edit_project_path(@project), notice: 'Project was saved.' 
        }
      else
        format.html { render :new, notice: "Please correct the errors below." }
      end
    end
  end

  def update_status
    respond_to do |format|
      
      project_status = project_status_params[:status]
      if project_status == "completed"
        @project.complete
      elsif project_status == "accepted"
        @project.accept
      elsif project_status == "seeking_freelancer"
        @project.seek
      end

      if @project.save
        format.html { 
          redirect_to @project, notice: 'Project status was updated!.' 
        }
        format.js {
          render plain: "Project status was updated!", status: :ok
        }
      else
        format.html { render :new, notice: "Please correct the errors below." }
        format.js { 
          puts @project.errors.inspect
          render plain: "An error occurred."
        }
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to home_projects_path, notice: "Your project was deleted."
  end
  
  

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def set_project_with_owner
      @project = Project.owned_by(current_user).find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :long_description, :goals, :deadline, :budget, { category_ids: [] } )
    end

    def project_status_params
      params.require(:project).permit(:status)
    end

    def payment_package_params
      params.require(:project).permit(:listing_package_id)
    end
end
