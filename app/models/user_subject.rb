class UserSubject < ActiveRecord::Base
  include PublicActivity::Model

  tracked only: [:finish_subject],
    owner: ->(controller, model) {controller.current_user},
    recipient: ->(controller, model) {model && model.course}
  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity", dependent: :destroy

  belongs_to :user
  belongs_to :course
  belongs_to :user_course
  belongs_to :course_subject
  has_many :user_tasks, dependent: :destroy

  accepts_nested_attributes_for :user_tasks

  after_create :create_user_tasks

  scope :load_user_subject, ->(user_id, course_id){where "user_id = ? AND course_id = ?", user_id, course_id}
  scope :load_users, ->status {where status: status}
  enum status: [:init, :progress, :finish]

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :subject, prefix: true, allow_nil: true

  class << self
    def update_all_status status
      if status == "start"
        load_users(statuses[:init]).update_all(status: statuses[:progress], start_date: Time.now)
      else
        load_users(statuses[:progress]).update_all(status: statuses[:finish], end_date: Time.now)
      end
    end
  end

  def update_status
    init? ? update_attributes(status: :progress, start_date: Time.now) :  update_attributes(status: :finish, end_date: Time.now)
  end

  def subject
    self.course_subject.subject
  end

  private
  def create_user_tasks
    course_subject.tasks.each do |task|
      UserTask.find_or_create_by(user_subject_id: id,
        user_id: user_course.user_id, task_id: task.id)
    end
  end
end
