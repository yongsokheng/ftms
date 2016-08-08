class Location < ApplicationRecord
  belongs_to :manager, class_name: User.name, foreign_key: :user_id

  has_many :profiles

  validates :name, presence: true
end
