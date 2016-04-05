class CloneCourseService
  def initialize course
    @course = course
  end

  def clone_course
    @success = ActiveRecord::Base.transaction do
      begin
        new_course = @course.dup
        new_course.save
        @course.course_subjects.each do |course_subject|
          new_course_subject = course_subject.dup
          new_course_subject.course_id = new_course.id
          new_course_subject.save
          task_clone_service = CloneTaskService.new course_subject, new_course_subject
          task_clone_service.clone_task
        end
      true
      rescue
        raise ActiveRecord::Rollback
        false
      end
    end
    @success
  end
end
