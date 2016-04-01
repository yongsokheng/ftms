class UserSubjectsController < ApplicationController
  load_and_authorize_resource
  before_action :load_course
  before_action :check_status_subject, only: :update

  def show
    @user_subject = UserSubject.find params[:id]
    @course = @user_subject.user_course.course
  end

  def update
    if @user_subject.update_attributes user_subject_params
      flash[:success] = flash_message "updated"
    else
      flash[:danger] = flash_message "not_updated"
    end
    redirect_to :back
  end

  private
  def user_subject_params
    params.require(:user_subject).permit user_tasks_attributes: [:id, :task_id, :_destroy, :user_id]
  end

  def load_course
    @course = @user_subject.course
    @user_course = @user_subject.user_course
    @activities = PublicActivity::Activity.course_activities(@course.id).
      recent.limit(20).decorate
  end

  def check_status_subject
    redirect_to :back if @user_subject.finish? || !@user_subject.course_subject.progress?
  end
end
