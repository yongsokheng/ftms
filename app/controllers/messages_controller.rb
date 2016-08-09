class MessagesController < ApplicationController
  def new
    chat_room_id = params[:id]
    chat_room_type = params[:type]

    if chat_room_type == User.name
      chat_room = Conversation.existing_conversation current_user.id, chat_room_id
      @chat_room = chat_room.present? ? chat_room.first :
        Conversation.create(sender_id: current_user.id, receiver_id: chat_room_id)
    else
      @chat_room = Course.find chat_room_id
    end

    @messages = @chat_room.messages.load_messages
    respond_to do |format|
      format.js
    end
  end
end
