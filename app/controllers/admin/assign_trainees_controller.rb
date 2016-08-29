class Admin::AssignTraineesController < ApplicationController
  load_and_authorize_resource :course
  authorize_resource class: false

  def edit
    @trainees = User.trainees.available_of_course @course.id

    add_breadcrumb_path "courses"
    add_breadcrumb @course.name, admin_course_path(@course)
    add_breadcrumb t "courses.assign_trainees"
  end

  def update
    if params[:course] && @course.update_attributes(course_params)
      flash[:success] = flash_message "updated"
    else
      flash[:danger] = flash_message "not_updated"
    end
    redirect_to admin_course_path @course
  end

  private
  def course_params
    params.require(:course).permit Course::USER_COURSE_ATTRIBUTES_PARAMS
  end
end
