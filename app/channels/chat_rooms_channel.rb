class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.courses.each do |course|
      stream_from "channel_course_#{course.id}"
    end
    stream_from "channel_conversation_#{current_user.id}"
  end

  def unsubscribed
  end
end
