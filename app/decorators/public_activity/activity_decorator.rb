class PublicActivity::ActivityDecorator < Draper::Decorator
  delegate_all

  def owner_name
    link owner
  end

  def verb
    case key
    when "course.finish_course"
      I18n.t "activity.finish_course"
    when "course.start_course"
      I18n.t "activity.start_course"
    when "user_course.create"
      I18n.t "activity.assign_trainee"
    when "user_course.destroy"
      I18n.t "activity.remove_trainee"
    when "user_subject.finish_subject"
      I18n.t "activity.finish_subject"
    when "course_subject.start_subject"
      I18n.t "activity.start_subject"
    when "course_subject.close_subject"
      I18n.t "activity.close_subject"
    when "user_task.create"
      I18n.t "activity.finish_task"
    when "course_subject.create"
      I18n.t "activity.assign_subject"
    when "user_subject.destroy", "course_subject.destroy"
      I18n.t "activity.remove_subject"
    else
      key
    end
  end

  def object_name
    link get_object_from_trackable
  end

  def conjunction
    case key
    when "user_course.create"
      parameters[:user].nil? ? I18n.t("activity.as_supervisor") : I18n.t("activity.to_course")
    when "course_subject.create"
      I18n.t "activity.to_course"
    when "user_course.destroy", "course_subject.destroy"
      I18n.t "activity.from_course"
    else
      ""
    end
  end

  def recipient_name
    case key
    when "user_course.create", "course_subject.create", "user_course.destroy", "course_subject.destroy"
      link recipient
    else
      ""
    end
  end

  def get_object_from_trackable
    case key
    when "course.finish_course", "course.start_course"
      trackable
    when "user_course.create", "user_course.destroy"
      parameters[:user].nil? ? owner : parameters[:user]
    when "user_subject.finish_subject"
      trackable.course_subject.subject
    when "course_subject.start_subject", "course_subject.close_subject"
      trackable.subject
    when "course_subject.create", "course_subject.destroy"
      parameters[:subject]
    when "user_task.create"
      trackable.task unless trackable.nil?
    else
      key
    end
  end

  def link object
  end
end
