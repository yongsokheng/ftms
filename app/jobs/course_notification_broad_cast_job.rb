class CourseNotificationBroadCastJob < ApplicationJob
  queue_as :default

  def perform course, key, current_user
    notification = Notification.create trackable_type: "Course",
      trackable_id: course.id, key: key, user_id: current_user
    course.users.each do |user|
      notification.user_notifications.create user_id: user.id
    end

    notify_content = "#{I18n.t "layouts.course"}
      #{I18n.t "notifications.keys.#{notification.key}", data: notification.trackable.name}"

    BroadCastService.new(notification, "channel_course_notification_#{course.id}",
      notify_content).broadcast
  end
end
