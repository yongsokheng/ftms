class Trainer::StatusSubjectsController < ApplicationController
  before_action :load_data

  def update
    @user_subjects.update_all_status params[:status], current_user, @course_subject
    respond_to do |format|
      format.js {render template: "trainer/user_subjects/update.js.erb"}
    end
  end

  private
  def load_data
    @course_subject = CourseSubject.find params[:course_subject_id]
    @course = @course_subject.course
    @user_subjects = @course_subject.user_subjects
    @subject = @course_subject.subject
  end
end

