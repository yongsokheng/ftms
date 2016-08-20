class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform channel, current_user, message_id, message = ""
    if message.present?
      channel_type = message.chat_room_type
      channel_id = message.chat_room_id if channel_type == Course.name
      message = render_message message, current_user
    end
    channel_id ||= current_user.id
    ActionCable.server.broadcast channel, message: message,
      message_id: message_id, channel_id: channel_id, channel_type: channel_type
  end


  private
  def render_message message, current_user
    ApplicationController.renderer.render(partial: "messages/message",
      locals: {message: message, current_user: current_user})
  end
end
