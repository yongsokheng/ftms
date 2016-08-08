class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :user_type
  belongs_to :university
  belongs_to :programming_language
  belongs_to :status
  belongs_to :location


  delegate :name, :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :university, prefix: true, allow_nil: true
  delegate :name, to: :user_type, prefix: true, allow_nil: true
  delegate :name, to: :status, prefix: true, allow_nil: true
  delegate :name, to: :programming_language, prefix: true, allow_nil: true
end
