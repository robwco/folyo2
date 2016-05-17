class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]
  before_action :set_project_with_owner, only: [:preview, :payment, :select_payment, :charge_payment, :collect_payment, :edit, :update, :destroy]
  before_filter :authenticate_any!, except: [:show]

  respond_to :html

  def home
	  render layout: "folyo"
  end

  def active
	  render layout: "folyo"
  end

  def yours
	  render layout: "folyo"
  end

  def index
    @projects = Project.all
    respond_with(@projects)
  end

  def show
	@reply = @project.reply_from(current_user)
	@reply = Reply.new unless @reply
	@message = Message.new
	render layout: "folyo"
  end

  def new
    @project = Project.new
	render layout: "folyo"
  end

  def preview
	render layout: "folyo"
  end

  def payment
	  @packages = ListingPackage.active.order(:price)
	render layout: "folyo"
  end

  def select_payment
	unless ListingPackage.active.find(payment_package_params[:listing_package_id])
	  redirect_to payment_project_path(@project) 
	  return
	end

    respond_to do |format|
      if @project.update(payment_package_params)
        format.html { 
			redirect_to collect_payment_project_path(@project) 
		}
      else
        format.html { redirect_to payment_project_path(@project), notice: "The package you selected was invalid." }
      end
    end

  end

  def collect_payment
	render layout: "folyo"
  end

  def charge_payment
	  if ChargeProject.call params[:stripeToken], @project
		redirect_to @project, notice: "Your payment was accepted."	
      else
        format.html { render :collect_payment, notice: "Please correct the errors below.", layout: "folyo" }
      end
  end

  def edit
	render layout: "folyo"
  end

  def create
    @project = Project.new(project_params)
	@project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { 
			redirect_to preview_project_path(@project), notice: 'Project was successfully created.' 
		}
      else
        format.html { render :new, notice: "Please correct the errors below.", layout: "folyo" }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { 
			redirect_to preview_project_path(@project), notice: 'Project was successfully edited.' 
		}
      else
        format.html { render :new, notice: "Please correct the errors below.", layout: "folyo" }
      end
    end
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def set_project_with_owner
      @project = Project.owned_by(current_user).find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :category, :goals, :examples, :deadline, :budget, :deliverables, :photo, 
									  :name, :email, :company_logo, :organization, :website, :spirit_animal)
    end

    def payment_package_params
      params.require(:project).permit(:listing_package_id)
    end
end
