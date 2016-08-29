class Admin::FeedBacksController < ApplicationController
  load_and_authorize_resource

  def index
    @feed_backs = @feed_backs.order_by_time
    add_breadcrumb_index "feed_backs"
  end
end
