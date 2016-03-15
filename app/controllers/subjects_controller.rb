class SubjectsController < ApplicationController
  before_action :load_course, only: :update
  before_action :check_status, only: :update
  before_action :check_status_subject, only: :update

  def index
    @user = User.find params[:user_id]
    @course = Course.find params[:course_id]
    @user_subjects = @user.user_subjects.where course_id: @course.id
  end

  private
  def load_course
    @user_subject = UserSubject.find params[:subject_id]
    @user_course = @user_subject.user_course
  end

  def check_status
    redirect_to :back unless params[:status] == Settings.finish
  end

  def check_status_subject
    redirect_to :back unless @user_subject.progress?
  end
end
