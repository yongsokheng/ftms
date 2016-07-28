class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :load_user_subject, only: [:create, :edit, :update, :destroy]
  before_action :add_task_info, only: [:create]
  before_action :load_user_course, only: [:edit, :destroy]

  def create
    if @task.save
      flash[:success] = flash_message "created"
    else
      flash[:failed] = flash_message "not_created"
    end
    redirect_to :back
  end

  def update
    @old_status = user_task.status
    if @task.update_attributes task_params
      flash[:success] = flash_message "updated"
    else
      flash[:failed] = flash_message "not_updated"
    end
    redirect_to :back
  end

  def destroy
    if @task.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deteletd"
    end
    redirect_to :back
  end

  private
  def task_params
    params.require(:task).permit Task::ATTRIBUTES_PARAMS
  end

  def add_task_info
    @task.create_by_trainee = current_user.is_trainee?
  end

  def load_user_subject
    @user_subject = UserSubject.find_by user: current_user,
      course_subject: @task.course_subject
  end

  def load_user_course
    @course_subject = @task.course_subject
    @user_course = current_user.user_courses.find_by course_id: @course_subject.course_id
  end

  def user_task
     @task.user_tasks.first
  end
end
