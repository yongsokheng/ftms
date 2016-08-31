class Location < ApplicationRecord
  belongs_to :manager, class_name: User.name, foreign_key: :user_id

  has_many :profiles

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  delegate :name, to: :manager, prefix: true, allow_nil: true
end
