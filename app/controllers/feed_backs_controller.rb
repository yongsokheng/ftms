class FeedBacksController < ApplicationController
  load_and_authorize_resource

  def create
    @feed_back = current_user.feed_backs.build feed_back_params
    if @feed_back.save
      flash.now[:success] = flash_message "created"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def feed_back_params
    params.require(:feed_back).permit FeedBack::FEED_BACK_ATTRIBUTES_PARAMS
  end
end
