class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

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

    respond_to do |format|
      if @message.save
        format.html { 
			redirect_to @reply, notice: 'Message was successfully created.' 
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

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:message)
    end
end
