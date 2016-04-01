class Admin::UserSubjectsController < ApplicationController
  load_and_authorize_resource
  before_action :load_data, only: :update

  def update
    @user_subject.update_status
    respond_to do |format|
      format.js
    end
  end

  private
  def load_data
    @course_subject = CourseSubject.find params[:course_subject_id]
    @course = @course_subject.course
    @user_subjects = @course_subject.user_subjects
  end
end
