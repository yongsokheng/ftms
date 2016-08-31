class CloneCourseService
  def initialize course
    @course = course
  end

  def clone_course
    @clone_course = ActiveRecord::Base.transaction do
      begin
        new_course = @course.dup
        new_course.status = Settings.course.init
        new_course.image = File.open @course.image.path if @course.image.path
        new_course.save!
        clone_course_subject @course, new_course
      true
      rescue
        raise ActiveRecord::Rollback
        false
      end
    end
    @clone_course
  end

  private
  def clone_course_subject old_course, new_course
    old_course.course_subjects.order_position.each do |course_subject|
      new_course_subject = CourseSubject.new course_id: course_subject.course.id,
        subject_id: course_subject.subject.id
      new_course_subject.course_id = new_course.id
      new_course_subject.save!
      clone_task course_subject, new_course_subject
    end
  end

  def clone_task old_course_subject, new_course_subject
    old_course_subject.tasks.not_created_by_trainee.each do |task|
      new_task = task.dup
      new_task.course_subject_id = new_course_subject.id
      new_task.save!
    end
  end
end
