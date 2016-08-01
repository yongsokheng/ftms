class TaskMaster < ApplicationRecord
  belongs_to :subject

  validates :name, presence: true

  after_create :create_course_tasks

  private
  def create_course_tasks
    subject.course_subjects.each do |course_subject|
      Task.create name: name, description: description,
        course_subject_id: course_subject.id, task_master_id: id
    end
  end
end
