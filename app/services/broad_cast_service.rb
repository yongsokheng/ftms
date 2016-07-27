class BroadCastService
  def initialize notification, channel, notify_content
    @notification = notification
    @channel = channel
    @notify_content = notify_content
  end

  def broadcast
    ActionCable.server.broadcast @channel, content: render_notification,
      notify_content: @notify_content
  end

  private
  def render_notification
    ApplicationController.renderer.render(partial: "shared/notification",
      locals: {notification: @notification})
  end
end
