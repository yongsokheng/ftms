class UserTask < ApplicationRecord
  include PublicActivity::Model

  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity",
    dependent: :destroy

  belongs_to :task
  belongs_to :user_subject
  belongs_to :user

  delegate :id, :name, :image_url, :description, to: :task, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :description, to: :task, prefix: true, allow_nil: true

  scope :user_task_of_subject_progress,
    -> {joins(:user_subject).where "user_subjects.status = ?",
      UserSubject.statuses[:progress]}

  enum status: [:in_progress, :finished]

  def nil_master?
    task.task_master_id.nil?
  end

  def create_by_trainee?
    task.create_by_trainee
  end

  def subject_in_progress?
    user_subject.progress?
  end
end
