class MessagesController < ApplicationController
  before_filter :authenticate_any!
  before_action :set_message, only: [:edit, :update, :destroy, :archive]

  respond_to :html

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
          ProjectMailer.delay.new_message(@message)
          redirect_to @reply, notice: 'Your message was sent!' 
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
      @message = Message.owned_by(current_user).find(params[:id])

      if @message.blank? || !@message.owned_by?(current_user)
        head :forbidden
      end
    end

    def message_params
      params.require(:message).permit(:message)
    end
end
