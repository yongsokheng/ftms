class Admin::DashboardController < ApplicationController
  authorize_resource class: false

  def index
    load_chart_data
    add_breadcrumb_index "dashboard"
  end

  private
  def load_chart_data
    @start_date = Date.today - Settings.number_day_of_user_chart.day
    @end_date = Date.today
    load_user_sign_up_in_day
    load_course_new_in_day
    load_course_finished_in_day
  end

  def load_user_sign_up_in_day
    @user_sign_up_chart_data = {}
    @users = User.created_between @start_date, @end_date
    @user_sign_up_chart_data = get_data @users, @user_sign_up_chart_data
  end

  def load_course_new_in_day
    @new_course_chart_data = {}
    @courses = Course.created_between @start_date, @end_date
    @new_course_chart_data = get_data @courses, @new_course_chart_data
  end

  def load_course_finished_in_day
    @finished_course_chart_data = {}
    @courses_finished = Course.finished_between @start_date, @end_date
    @finished_course_chart_data = get_data @courses_finished,
      @finished_course_chart_data
  end

  def get_data datas, hash
    (@start_date..@end_date).each do |date|
      datas.each do |data|
        if data.created_at.to_date == date && hash[date]
          hash[date] += 1
        elsif data.created_at.to_date == date
          hash[date] = 1
        elsif hash[date].nil?
          hash[date] = 0
        end
      end
    end
    hash = hash.map {|key, value| [key.to_s, value]}
  end
end
