class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :preview, :post, :update, :archive, :destroy, :message]
  before_filter :authenticate_any! , except: [:create, :without_user]

  respond_to :html

  def index
    @replies = Reply.all
    respond_with(@replies)
  end

  def show
	  @message = Message.new
	  @project = @reply.project
    @unread_messages = @reply.messages.select{|m| m.unread? && m.sent_to?(current_user)}
    update_read_count
  end

  def new
    @reply = Reply.new
    render plain: @reply.inspect
  end

  def edit
    @project = @reply.project
  end

  def preview
  end

  def post
    @reply.publish
    redirect_to @reply.project
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.project = Project.find(params[:project_id])

    redirect_to(root_path) and return if @reply.project.archived

    if current_user.blank?
      session[:unsent_reply_biography] = @reply.biography
      session[:unsent_reply_message] = @reply.message
      session[:unsent_reply_next_steps] = @reply.next_steps
      session[:unsent_reply_project_id] = @reply.project.id
      redirect_to(without_user_replies_path) and return
    end

    @reply.user = current_user

    can_reply_with_portfolio = current_user.can_reply_with_portfolio?(@reply.project)

    unless can_reply_with_portfolio
      @reply.portfolio_message = nil
      @reply.portfolio_image = nil
    else
      @reply.has_portfolio = true
      @reply.published = true
    end

    respond_to do |format|
      if @reply.save
        format.html { 
          if can_reply_with_portfolio
            redirect_to @reply.project, notice: "Your message was sent!"
          else
            redirect_to preview_reply_path(@reply) 
          end
        }
      else
        @project = @reply.project
        flash[:error] = "Please correct the errors below." 
        format.html { render "projects/show" }
      end
    end
  end

  def without_user
    @user = User.new
    @user.account_type = "freelancer"
    @user.biography = session[:unsent_reply_biography]
    @plan = Plan.active.where(amount: 0).first
  end

  def complete
    if session[:unsent_reply_biography]
      reply = Reply.new
      reply.biography = session[:unsent_reply_biography]
      reply.message = session[:unsent_reply_message]
      reply.next_steps = session[:unsent_reply_next_steps]
      reply.project = Project.find(session[:unsent_reply_project_id])
      reply.user = current_user

      if reply.save
        session.delete(:unsent_reply_biography)
        session.delete(:unsent_reply_message)
        session.delete(:unsent_reply_next_steps)
        session.delete(:unsent_reply_project_id)

        redirect_to preview_reply_path(reply)
      else
        flash[:error] = "There was a problem creating your reply. Please try again."
        redirect_to reply.project
      end
    end
  end

  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { 
          @reply.publish
          redirect_to @reply.project, notice: 'Your message was sent!'
        }
      else
        format.html { render :edit, notice: "Please correct the errors below." }
      end
    end
  end

  def archive
    @reply.archive
    redirect_to @reply.project, notice: "Reply was archived!"
  end
  
  def message
	  @message = Message.new

  end 

  def destroy
    @reply.destroy
    respond_with(@reply)
  end

  private
    def set_reply
      @reply = Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:project_id, :biography, :message, :next_steps, :portfolio_message, :portfolio_image)
    end

    def update_read_count
      @reply.mark_read(current_user) 
      set_unread_message_count
    end
end
