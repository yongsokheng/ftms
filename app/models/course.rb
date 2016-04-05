class Course < ActiveRecord::Base
  include PublicActivity::Model
  include InitUserSubject
  tracked only: [:finish_course, :start_course],
    owner: ->(controller, model) {controller.current_user}
  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity", dependent: :destroy

  validate :check_day_present, on: [:create, :update]
  validate :check_end_date, on: [:create, :update]

  validates :start_date, presence: true
  validates :end_date, presence: true

  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects

  enum status: [:init, :progress, :finish]

  scope :recent, ->{order created_at: :desc}

  scope :active_course, ->{where status: "progress"}


  accepts_nested_attributes_for :user_courses, allow_destroy: true

  USER_COURSE_ATTRIBUTES_PARAMS = [user_courses_attributes: [:id, :user_id, :_destroy]]
  COURSE_ATTRIBUTES_PARAMS = [:name, :description, :start_date,
    :end_date, subject_ids: []]

  def create_user_subjects_when_start_course
    create_user_subjects user_courses, course_subjects, id, false
  end

  def check_day_present
    unless self.start_date.nil?
      self.errors.add :start_date, I18n.t("error.wrong_date") if
        self.start_date.to_date < Date.today
    end
  end

  def check_end_date
    unless self.start_date.nil?
      errors.add :end_date, I18n.t("error.wrong_end_date") if
        self.end_date < self.start_date
    end
  end

  def start_course
    self.update_attributes status: :progress
  end

  def finish_course
    self.update_attributes status: :finish
    self.user_subjects.update_all(status: Course.statuses[:finish])
  end
end
