class Trainer::FeedBacksController < ApplicationController
  load_and_authorize_resource

  def index
    @feed_backs = FeedBack.order_by_time
    add_breadcrumb_index "feed_backs"
  end
end
