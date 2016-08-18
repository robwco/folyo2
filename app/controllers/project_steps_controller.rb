class ProjectStepsController < ApplicationController
	include Wicked::Wizard

  steps :company_profile, :project_brief

  before_filter :authenticate_any!
  before_action :set_project_with_owner, except: [:new]

  def show
    render_wizard
  end


  def update
    @project.status = step.to_s
    case step
    when :company_profile
      @project.update_attributes(company_profile_params)
    when :project_brief
      @project.update_attributes(project_brief_params)
    end

    render_wizard @project
  end


  def new
    @project = Project.create(user: current_user)
    next_step = steps.first
    next_step = steps.last if current_user.company_name.present?

    redirect_to wizard_path(next_step, :project_id => @project.id) 
  end

  private
    def set_project_with_owner
      @project = Project.owned_by(current_user).find(params[:project_id])
    end
    def company_profile_params
      params.require(:project).permit(:company_logo, :organization, :website, :company_description)
    end
    def project_brief_params
      params.require(:project).permit(:title, :category, :goals, :examples, :deadline, :budget, :deliverables, :photo, 
									  :name, :email, :spirit_animal)
    end
    def finish_wizard_path
      preview_project_path(@project)	
    end
end
