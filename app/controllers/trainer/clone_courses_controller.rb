class Trainer::CloneCoursesController < ApplicationController
  load_and_authorize_resource :course
  authorize_resource class: false

  def create
    clone_course_service = CloneCourseService.new @course
    @clone_course = clone_course_service.clone_course
    if @clone_course
      flash[:success] = t "courses.confirms.clone_success"
    else
      flash[:failed] = t "courses.confirms.not_clone"
    end
    redirect_to trainer_courses_path
  end
end
