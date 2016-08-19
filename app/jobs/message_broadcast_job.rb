class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform channel, current_user, message_id, message = ""
    message = render_message(message, current_user) if message.present?
    ActionCable.server.broadcast channel, message: message, id: message_id
  end

  private
  def render_message message, current_user
    ApplicationController.renderer.render(partial: "messages/message",
      locals: {message: message, current_user: current_user})
  end
end
