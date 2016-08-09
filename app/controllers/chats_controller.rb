class ChatsController < ApplicationController
  def index
    @courses = current_user.courses
    @users = User.per_page_kaminari(params[:page]).per Settings.per_page
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
