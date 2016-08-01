class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :permissions, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  accepts_nested_attributes_for :permissions, allow_destroy: true

  ATTRIBUTES_PARAMS = [permissions_attributes: [:id, :model_class, :action, :_destroy]]

  scope :not_admin, ->{where.not name: "admin"}
  scope :trainee, ->{where name: "trainee"}
end
