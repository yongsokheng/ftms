class Admin::UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    if params[:user_subject].present?
      if @user_subject.update_attributes user_subject_params
        flash.now[:success] = flash_message "updated"
      else
        flash.now[:danger] = flash_message "not_updated"
      end
    else
      @user_subject.update_status current_user
    end
    load_data
    respond_to do |format|
      format.js
    end
  end

  private
  def user_subject_params
    params.require(:user_subject).permit UserSubject::ATTRIBUTES_PARAMS
  end

  def load_data
    @course_subject = CourseSubject.includes(:subject, :course, :tasks,
      user_subjects: [:user, :course_subject, user_tasks: [:user, :task]])
      .find params[:course_subject_id]
    @course = @course_subject.course
    @subject = @course_subject.subject
    @user_subjects = @course_subject.user_subjects
    @user_subjects_not_finishs = @user_subjects.not_finish @user_subjects.finish
  end
end
