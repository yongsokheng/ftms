class CourseNotificationBroadCastJob < ApplicationJob
  queue_as :default

  def perform course, key, current_user, user_subject = ""
    if user_subject.present?
      notification = Notification.create trackable_type: "UserSubject",
        trackable_id: user_subject.id, key: key, user_id: current_user
      notify_content = "#{I18n.t "layouts.subject"}
        #{I18n.t "notifications.keys.#{notification.key}",
        data: notification.trackable.course_subject.subject_name}
        #{I18n.t "user_subjects.notifications.user", user: notification.user.name}"
    else
      notification = Notification.create trackable_type: "Course",
        trackable_id: course.id, key: key, user_id: current_user
      notify_content = "#{I18n.t "layouts.course"}
        #{I18n.t "notifications.keys.#{notification.key}",
        data: notification.trackable.name}"
    end

    course.users.each do |user|
      notification.user_notifications.create user_id: user.id
    end

    BroadCastService.new(notification, "channel_course_notification_#{course.id}",
      notify_content).broadcast
  end
end
