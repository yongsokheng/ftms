class Trainer::ChangeStatusCoursesController < ApplicationController
  load_and_authorize_resource :course
  authorize_resource class: false

  def update
    if @course.init?
      @course.start_course current_user
      key = Notification.keys[:start]
      flash[:success] = flash_message "start_course"
    elsif @course.progress?
      key = Notification.keys[:finish]
      @course.finish_course current_user
      flash[:success] = flash_message "finish_course"
    elsif @course.finish?
      key = Notification.keys[:reopen]
      @course.reopen_course current_user
      flash[:success] = flash_message "reopen_course"
    else
      flash[:failed] = flash_message "course_not_upate"
    end
    CourseNotificationBroadCastJob.perform_now @course, key, current_user.id
    redirect_to trainer_course_path @course
  end
end
