class Trainer::UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    @user_subject.update_status current_user
    load_data
    respond_to do |format|
      format.js
    end
  end

  private
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
