class UserDecorator < Draper::Decorator
  delegate_all

  def user_course_last_actived
    courses.last
  end

  def allow_access_admin
    roles.exists? allow_access_admin: true
  end
end
