class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform channel, message = "", current_user
    message = render_message(message, current_user) if message.present?
    ActionCable.server.broadcast channel, message: message
  end

  private
  def render_message message, current_user
    ApplicationController.renderer.render(partial: "messages/message",
      locals: {message: message, current_user: current_user})
  end
end
