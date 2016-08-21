class StaticPagesController < ApplicationController
  def home
    if current_user.present? && !current_user.is_trainee?
      redirect_to admin_root_path
    end
    @trainees_size = User.trainees.size
    @trainers_size = User.trainers.size
    @courses_size = Course.all.size
  end
end
