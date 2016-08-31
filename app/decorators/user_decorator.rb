class UserDecorator < Draper::Decorator
  delegate_all

  def user_course_last_actived
    courses.last
  end
end
