class Task < ActiveRecord::Base
  belongs_to :course_subject
  has_many :user_tasks, dependent: :destroy
  belongs_to :assigned_trainee, class_name: User.name

  ATTRIBUTES_PARAMS = [
    :name, :description, :assigned_trainee_id, :course_subject_id
  ]

  scope :not_assigned_trainee, -> do
    where assigned_trainee_id: nil, task_master_id: nil
  end

  scope :find_admin_tasks, ->{where admin_task: 1}

  after_save :change_user_task

  private
  def change_user_task
    return if assigned_trainee.nil?
    user_task = user_task_of_trainee
    if user_task.nil?
      self.user_tasks.create user: assigned_trainee,
        user_subject: user_subject
    else
      user_task.update_attributes user: assigned_trainee,
        user_subject: user_subject
    end
  end

  def user_task_of_trainee
    UserTask.find_by user: self.changed_attributes["assigned_trainee_id"],
      task: self
  end

  def user_subject
    self.course_subject.user_subjects.find_by user: assigned_trainee
  end
end
