class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if user_signed_in?
      @message.anon_author_name = nil
      @message.user_author_id = current_user.id
      @message.email = current_user.email
    end

    if @message.save
      MessageMailer.message_email(@message).deliver_now
      flash[:success] = 'Сообщение отправлено'
      redirect_to new_message_path
    else
      render :new
    end
  end

  private
    def message_params
      params.require(:message).permit(:anon_author_name, :title, :body, :email)
    end
end
