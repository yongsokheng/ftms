class ChatsController < ApplicationController
  def index
    @users = User.ransack(name_cont: params[:q]).result
      .per_page_kaminari(params[:page]).per Settings.chats.chat_room_per_page
    @courses = current_user.courses.ransack(name_cont: params[:q]).result

    respond_to do |format|
      format.html
      format.js
    end
  end
end
