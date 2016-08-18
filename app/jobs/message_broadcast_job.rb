class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform channel, message = ""
    message = render_message(message) if message.present?
    ActionCable.server.broadcast channel, message: message
  end

  private
  def render_message message
    ApplicationController.renderer.render(partial: "messages/message",
      locals: {message: message})
  end
end
