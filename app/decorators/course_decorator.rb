class CourseDecorator < Draper::Decorator
  delegate_all
  include ApplicationHelper

  def set_status
    "<span class='label-status #{set_background_color_status course.status}'>
      #{I18n.t "courses.labels.status.#{self.status}"}</span>".html_safe
  end
end
