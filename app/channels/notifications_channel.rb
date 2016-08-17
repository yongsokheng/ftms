class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    current_user.courses.each do |course|
      stream_from "channel_course_notification_#{course.id}"
    end

    current_user.user_subjects.each do |user_subject|
      stream_from "channel_user_subject_#{user_subject.id}"
    end
  end

  def unsubscribed
  end
end
