class CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :load_course, only: [:index]

  def index
  end

  def show
    unless current_user.is_trainee?
      redirect_to [:admin, @course]
    else
      user_course = @course.user_courses.find_by user_id: current_user.id
      redirect_to user_course
    end
  end

  private
  def load_course
    redirect_to admin_courses_path unless current_user.is_trainee?
    @user_courses = current_user.user_courses.course_not_init
  end
end
