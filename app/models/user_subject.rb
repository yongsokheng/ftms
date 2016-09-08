class UserSubject < ApplicationRecord
  include PublicActivity::Model

  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity", dependent: :destroy

  belongs_to :user
  belongs_to :course
  belongs_to :user_course
  belongs_to :course_subject
  has_many :user_tasks, dependent: :destroy
  has_many :notifications, as: :trackable, dependent: :destroy

  accepts_nested_attributes_for :user_tasks

  after_create :create_user_tasks

  ATTRIBUTES_PARAMS = [:start_date, :end_date]

  scope :load_user_subject, ->(user_id, course_id){where "user_id = ? AND course_id = ?", user_id, course_id}
  scope :load_users, ->status {where status: status}
  scope :not_finish, -> user_subjects {where.not(id: user_subjects)}
  scope :sort_by_course_subject, ->{joins(:course_subject).order("course_subjects.order asc")}
  scope :order_by_course_subject , ->{joins(:course_subject).order "course_subjects.row_order"}

  scope :load_by_course_subject, ->course_subject_ids, trainer_id do
    order_by_course_subject.joins(:user).where("course_subjects.id in (?)
      AND user_subjects.status = ? AND users.trainer_id = ?", course_subject_ids,
      UserSubject.statuses[:progress], trainer_id).includes :user
  end

  enum status: [:init, :progress, :finish]

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, :description, to: :subject, prefix: true, allow_nil: true
  delegate :name, to: :course, prefix: true, allow_nil: true

  validate :check_end_date

  def load_trainers
    course.users.trainers
  end

  def load_trainees
    course.users.trainees
  end

  class << self
    def update_all_status status, current_user, course_subject
      if status == "start"
        load_users(statuses[:init]).update_all(status: statuses[:progress],
          start_date: Time.now)
        key = "user_subject.start_all_subject"
      else
        load_users(statuses[:init]).update_all status: statuses[:progress],
          start_date: Time.now
        load_users(statuses[:progress]).update_all status: statuses[:finish],
          end_date: Time.now
        key = "user_subject.finish_all_subject"
      end
      course_subject.create_activity key: key, owner: current_user, recipient: course_subject.course
    end
  end

  def update_status current_user
    if init?
      update_attributes(status: :progress, start_date: Time.now,
        end_date: Time.now + during_time.days)
      key = "user_subject.start_subject"
      notification_key = Notification.keys[:start]
    else
      update_attributes status: :finish, user_end_date: Time.now
      key = "user_subject.finish_subject"
      notification_key = Notification.keys[:finish]
    end
    create_activity key: key, owner: current_user, recipient: user
    if is_of_user? current_user
      CourseNotificationBroadCastJob.perform_now course, notification_key, current_user.id, self
    else
      UserSubjectNotificationBroadCastJob.perform_now self, notification_key, current_user.id
    end
  end

  def subject
    self.course_subject.subject
  end

  def name
    course_subject.subject_name
  end

  def description
    course_subject.subject.description
  end

  def content
    course_subject.subject.content
  end

  def image_url
    course_subject.image_url
  end

  def is_of_user? user
    self.user == user
  end

  def percent_progress
    if start_date.present?
      current_date = user_end_date
      current_date ||= Time.zone.today 
      user_current_time = (current_date - start_date).to_f
      percent = user_current_time * 100 / (end_date - start_date).to_f
      [percent, 100].min
    end
  end

  private
  def create_user_tasks
    course_subject.tasks.each do |task|
      UserTask.find_or_create_by(user_subject_id: id,
        user_id: user_course.user_id, task_id: task.id)
    end
  end

  def check_end_date
    errors.add :end_date, I18n.t("error.wrong_end_date") if
      start_date.present? && (start_date > Date.today || start_date > end_date)
  end
end
