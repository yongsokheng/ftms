class Admin::DashboardController < ApplicationController
  authorize_resource class: false

  def index
    load_chart_data
  end

  private
  def load_chart_data
    @user_sign_up_chart_data = {}
    start_date = Date.today - Settings.number_day_of_user_chart.day
    end_date = Date.today
    @users = User.created_between start_date, end_date
    @user_sign_up_chart_data = get_data @users, start_date, end_date, @user_sign_up_chart_data
  end

  def get_data datas, start_date, end_date, hash
    (start_date..end_date).each do |date|
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
