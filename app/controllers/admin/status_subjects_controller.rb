class Admin::StatusSubjectsController < ApplicationController
  before_action :load_data

  def update
    @user_subjects.update_all_status params[:status]
    respond_to do |format|
      format.js {render template: "admin/user_subjects/update.js.erb"}
    end
  end

  private
  def load_data
    @course_subject = CourseSubject.find params[:course_subject_id]
    @course = @course_subject.course
    @user_subjects = @course_subject.user_subjects
  end
end

