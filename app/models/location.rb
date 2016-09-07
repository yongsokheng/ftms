class Location < ApplicationRecord
  belongs_to :manager, class_name: User.name, foreign_key: :user_id

  has_many :profiles

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :manager, presence: true, uniqueness: {case_sensitive: false}

  delegate :name, to: :manager, prefix: true, allow_nil: true

  after_save :update_user_location

  private
  def update_user_location
    manager_profile = Profile.find_or_initialize_by user_id: manager.id
    manager_profile.location_id = id
    manager_profile.save
  end
end
