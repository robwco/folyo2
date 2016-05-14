class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :preview, :post, :update, :destroy]
  before_filter :authenticate_any! #, except: [:show]

  respond_to :html

  def index
    @replies = Reply.all
    respond_with(@replies)
  end

  def show
	  @message = Message.new
	render layout: "folyo"
  end

  def new
    @reply = Reply.new
	render plain: @reply.inspect
  end

  def edit
	@project = @reply.project
	render layout: "folyo"
  end

  def preview
	render layout: "folyo"
  end

  def post
	@reply.published = true
	@reply.save
	redirect_to @reply.project
  end

  def create
    @reply = Reply.new(reply_params)
	@reply.project = Project.find(params[:project_id])
	@reply.user = current_user

    respond_to do |format|
      if @reply.save
        format.html { 
			redirect_to preview_reply_path(@reply), notice: 'Project reply was successfully created.' 
		}
      else
        format.html { render :new, notice: "Please correct the errors below.", layout: "folyo" }
      end
    end
  end

  def update
    respond_to do |format|
		if @reply.update(reply_params)
			format.html { 
				redirect_to preview_reply_path(@reply), notice: 'Project reply was successfully updated.' 
			}
		else
			format.html { render :edit, notice: "Please correct the errors below.", layout: "folyo" }
		end
	end
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
      params.require(:reply).permit(:message, :portfolio_message, :project_id)
    end
end
