class User < ApplicationRecord

  QUERY = "id NOT IN (SELECT user_id
    FROM user_courses, courses WHERE user_courses.course_id = courses.id
    AND (courses.status = 0 OR courses.status = 1)
    AND courses.id <> :course_id) AND role_id = 3"

  mount_uploader :avatar, ImageUploader

  belongs_to :trainer, class_name: User.name, foreign_key: :trainer_id
  belongs_to :role

  has_one :location
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :course_subjects, through: :user_subjects
  has_many :tasks, through: :user_tasks
  has_one :profile, dependent: :destroy
  has_one :evaluation
  has_many :trainees, class_name: User.name, foreign_key: :trainer_id
  has_many :notes, dependent: :destroy
  has_many :notifications
  has_many :user_notifications, dependent: :destroy
  has_many :senders, class_name: Conversation.name, foreign_key: :sender_id,
    dependent: :destroy
  has_many :receivers, class_name: Conversation.name, foreign_key: :receiver_id,
    dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates_confirmation_of :password

  ATTRIBUTES_PROFILE_PARAMS = [
    :id, :start_training_date, :leave_date, :finish_training_date,
    :ready_for_project, :contract_date, :naitei_company,
    :user_type_id, :university_id, :programming_language_id, :user_progress_id,
    :status_id, :location_id
  ]

  ATTRIBUTES_PARAMS = [:name, :email, :password,
    :password_confirmation, :avatar, :role_id, :trainer_id,
    profile_attributes: ATTRIBUTES_PROFILE_PARAMS]

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  delegate :id, :name, to: :role, prefix: true, allow_nil: true

  scope :available_of_course, ->course_id{where QUERY, course_id: course_id}
  scope :trainers, ->{joins(:role).where("roles.name = 'trainer'")}
  scope :trainees, ->{joins(:role).where("roles.name = 'trainee'")}
  scope :find_course, ->course{joins(:user_courses)
    .where("user_courses.course_id in (?)", course).uniq}
  scope :show_members, ->{order(:role_id, :name).limit Settings.number_member_show}
  scope :select_all, ->{joins :role}
  scope :not_trainees, ->{joins(:role).where("roles.name != 'trainee'")}
  scope :by_location, ->location_id{
    joins(:profile).where("profiles.location_id = ?", location_id)
  }

  delegate :total_point, :current_rank, to: :evaluation, prefix: true, allow_nil: true

  after_create :create_user_profile
  before_validation :set_password

  accepts_nested_attributes_for :profile

  def total_done_tasks user, course
    done_tasks = UserSubject.load_user_subject(user.id, course.id).map(&:user_tasks).flatten.count
  end

  def owner_course course
    return course.user_courses.find_by(supervisor_id: self.id) ? true :false
  end

  def leader_course course
    return course.user_courses.find_by(leader_id: self.id) ? true :false
  end

  def is_admin?
    self.role.name == "admin"
  end

  def is_trainee?
    role.name == "trainee"
  end

  def in_course? course
    user_courses.exists? course_id: course
  end

  private
  def password_required?
    new_record? ? super : false
  end

  def create_user_profile
    create_profile user_id: id
  end

  def set_password
    self.password = Settings.default_password
    self.password_confirmation = Settings.default_password
  end
end
