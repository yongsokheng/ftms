class MessagesController < ApplicationController
  before_action :load_chat_room, only: :new

  def new
    @messages = @chat_room.messages.load_messages
  end

  def create
    @message = current_user.messages.create message_params
  end

  private
  def load_chat_room
    chat_room_id = params[:id]
    chat_room_type = params[:type]
    if chat_room_type == Conversation.name
      chat_room = Conversation.existing_conversation current_user.id, chat_room_id
      @chat_room = chat_room.present? ? chat_room.first :
        Conversation.create(sender_id: current_user.id, receiver_id: chat_room_id)
    else
      @chat_room = Course.find chat_room_id
    end
  end

  def message_params
    params.require(:message).permit :chat_room_id, :content, :chat_room_type
  end
end
