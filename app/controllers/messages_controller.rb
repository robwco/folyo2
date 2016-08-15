class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :archive]

  respond_to :html

  def index
    @messages = Message.all
    respond_with(@messages)
  end

  def show
    respond_with(@message)
  end

  def new
    @message = Message.new
    respond_with(@message)
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @reply = Reply.published.find(params[:reply_id])
    @message.reply = @reply
    @message.project = @reply.project
    @message.user = current_user
    @message.to_user_id = @reply.user_id
    @message.to_user_id = @reply.project.user_id if @message.to_user_id == current_user.id

    respond_to do |format|
      if @message.save
        format.html { 
          redirect_to @reply, notice: 'Message was sent!' 
        }
      else
        format.html { render :new, notice: "Please correct the errors below.", layout: "folyo" }
      end
    end
  end

  def update
    @message.update(message_params)
    respond_with(@message)
  end

  def destroy
    @message.destroy
    respond_with(@message)
  end

  def archive
    @message.archive
    respond_to do |format|
      format.js { render :show, status: :ok, location: @message }        
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:message)
    end
end
