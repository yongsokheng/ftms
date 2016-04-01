class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @subject = Subject.new
    @subjects = @subjects.recent
  end

  def show
    @task_masters = @subject.task_masters
    @course = Course.find params[:course_id]
    @course_subject = CourseSubject.find_by course_id: @course.id, subject_id: @subject.id
    @user_subjects = @course_subject.user_subjects
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = flash_message "created"
      redirect_to admin_subjects_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = flash_message "updated"
      redirect_to admin_subjects_path
    else
      flash[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = flash_message "deleted"
    else
      flash.now[:failed] = flash_message "not_deleted"
    end
    respond_to do |format|
      format.html {redirect_to admin_subjects_path}
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description, :during_time,
      task_masters_attributes: [:id, :name, :description, :_destroy]
  end
end
