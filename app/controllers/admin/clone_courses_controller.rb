class Admin::CloneCoursesController < ApplicationController
  load_and_authorize_resource :course

  def create
    course_clone_service = CloneCourseService.new @course
    @success = course_clone_service.clone_course
    if @success
      flash[:success] = t "courses.confirms.clone_success"
    else
      flash[:alert] = t "courses.confirms.not_clone"
    end
    redirect_to admin_courses_path
  end
end
