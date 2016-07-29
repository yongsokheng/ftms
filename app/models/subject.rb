class Subject < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :task_masters, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :documents, as: :documentable
  has_many :notifications, as: :trackable, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :during_time, presence: true, numericality: {greater_than: 0}

  scope :subject_not_start_course, ->course{where "id NOT IN (SELECT subject_id
    FROM course_subjects WHERE course_id = ? AND status <> 0)", course.id}

  scope :recent, ->{order created_at: :desc}

  accepts_nested_attributes_for :task_masters, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:name].blank?}

  accepts_nested_attributes_for :documents, allow_destroy: true,
    reject_if: proc {|attributes| attributes["content"].blank?}

  SUBJECT_ATTRIBUTES_PARAMS = [:name, :description, :content, :image, :during_time,
    documents_attributes: [:id, :name, :content, :_destroy],
    task_masters_attributes: [:id, :name, :description, :_destroy,
    documents_attributes: [:id, :name, :content, :_destroy]]]
end
