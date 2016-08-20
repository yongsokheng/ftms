class UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    @user_subject.update_status current_user
    @user_course = @user_subject.user_course
    redirect_to user_course_subject_path @user_course, @user_subject.subject
  end
end
