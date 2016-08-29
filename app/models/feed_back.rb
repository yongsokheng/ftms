class FeedBack < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  FEED_BACK_ATTRIBUTES_PARAMS = [:content]
end
