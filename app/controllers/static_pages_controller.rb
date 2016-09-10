class StaticPagesController < ApplicationController
  def home
    if current_user.present?
      if current_user.is_admin?
        redirect_to admin_root_path
      elsif current_user.is_trainer?
        redirect_to trainer_root_path
      end
    end
    @trainees_size = User.trainees.size
    @trainers_size = User.trainers.size
    @courses_size = Course.all.size
  end
end
