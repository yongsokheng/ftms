class FeedBack < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  FEED_BACK_ATTRIBUTES_PARAMS = [:content]

  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :order_by_time, ->{includes(:user).order created_at: :desc}
end
