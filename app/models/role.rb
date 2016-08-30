class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  accepts_nested_attributes_for :permissions, allow_destroy: true

  ATTRIBUTES_PARAMS = [permissions_attributes: [:id, :model_class, :action, :_destroy]]
  ATTRIBUTES_ROLE_PARAMS = [:name, :allow_access_admin, :role_type]

  scope :not_admin, ->{where.not name: "admin"}

  enum role_type: [:admin, :trainer, :trainee]

end
