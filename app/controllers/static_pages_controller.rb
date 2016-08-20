class StaticPagesController < ApplicationController
  def home
    @trainees_size = User.trainees.size
    @trainers_size = User.trainers.size
    @courses_size = Course.all.size
  end
end
