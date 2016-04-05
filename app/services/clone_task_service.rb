class CloneTaskService
  def initialize old_course_subject, new_course_subject
    @old_course_subject = old_course_subject
    @new_course_subject = new_course_subject
  end

  def clone_task
    @old_course_subject.tasks.find_admin_tasks.each do |task|
      new_task = task.dup
      new_task.course_subject_id = @new_course_subject.id
      new_task.save
    end
  end
end
