class MessagesController < ApplicationController
  before_action :message_of_correct_user, only: [:destroy, :update]
  before_action :load_chat_room, only: :new
  before_action :find_active_room, except: :new
  after_action :broadcast_message, except: :new

  def new
    unread_messages = @chat_room.messages.unread_by current_user
    unread_messages.mark_as_read! :all, for: current_user

    @messages = @chat_room.messages.read_by(current_user).order(created_at: :desc)
      .per_page_kaminari(params[:page]).per Settings.chats.message_per_page
  end

  def create
    @message = current_user.messages.create message_params
    @message.mark_as_read! for: current_user
  end

  def destroy
    if @message.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  def update
    @message.update_attributes message_params
  end

  private
  def message_params
    params.require(:message).permit :chat_room_id, :content, :chat_room_type
  end

  def message_of_correct_user
    @message = Message.find_by_id params[:id]
    unless @message.is_owner? current_user.id
      flash[:failed] = flash_message "not_deleted"
      redirect_to chats_path
    end
  end

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

  def find_active_room
    @active_room_id = params[:active_room_id]
  end

  def broadcast_message
    channel = "channel_#{@message.chat_room_type.downcase}_#{@active_room_id}"
    message = @message unless action_name == "destroy"
    MessageBroadcastJob.perform_later channel, current_user, @message.id, message
  end
end
