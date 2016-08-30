class Trainer::TasksController < ApplicationController
  load_and_authorize_resource
  load_and_authorize_resource :course_subject
  before_action :add_task_info, only: [:create]

  def new
    load_breadcrumbs
    add_breadcrumb t("breadcrumbs.subjects.new_task")
  end

  def edit
    load_breadcrumbs
    add_breadcrumb @task.name,
      trainer_course_subject_task_path(@course_subject, @task.user_tasks.first)
    add_breadcrumb t("breadcrumbs.subjects.edit")
  end

  def create
    if @task.save
      flash[:success] = flash_message "created"
      redirect_to edit_trainer_course_course_subject_path(@course_subject.course,
        @course_subject)
    else
      flash[:failed] = flash_message "not_created"
      redirect_to :back
    end
  end

  def update
    @old_assigned_trainee = @task.assigned_trainee
    if @task.update_attributes task_params
      flash[:success] = flash_message "updated"
    else
      flash[:failed] = flash_message "not_updated"
    end
    unless params[:task][:assigned_trainee_id].nil?
      @task.change_user_task @old_assigned_trainee
    end
    redirect_to :back
  end

  def destroy
    if @task.destroy
      flash[:success] = flash_message "deleted"
      redirect_to trainer_course_subject_path(@course_subject.course,
        @course_subject.subject)
    else
      flash[:failed] = flash_message "not_deleted"
      redirect_to :back
    end
  end

  private
  def task_params
    params.require(:task).permit Task::ATTRIBUTES_PARAMS
  end

  def load_breadcrumbs
    add_breadcrumb_path "courses"
    add_breadcrumb @course_subject.course_name,
      trainer_course_path(@course_subject.course)
    add_breadcrumb @course_subject.subject_name,
      trainer_course_subject_path(@course_subject.course, @course_subject.subject)
  end

  def add_task_info
    @task.create_by_trainee = current_user.is_trainee?
    @task.course_subject = @course_subject
  end
end

