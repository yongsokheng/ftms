class UserSubjectNotificationBroadCastJob < ApplicationJob
  queue_as :default

  def perform user_subject, key, current_user
    notification = Notification.create trackable_type: "UserSubject",
      trackable_id: user_subject.id, key: key,
      user_id: current_user

    notification.user_notifications.create user_id: user_subject.user_id

    notify_content = "#{I18n.t "layouts.subject"}
      #{I18n.t "notifications.keys.#{notification.key}",
      data: notification.trackable.course_subject.subject_name}"

    BroadCastService.new(notification, "channel_user_subject_#{user_subject.id}",
      notify_content).broadcast
  end
end
