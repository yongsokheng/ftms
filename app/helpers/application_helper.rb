module ApplicationHelper
  def full_title page_title = ""
    base_title = t "staticpages.framgia"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error, :failed then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def flash_message flash_type, *params
    if params.empty?
      t "flashs.messages.#{flash_type}", model_name: controller_name.classify
    else
      t "flashs.messages.#{flash_type}",
        models_name: params[0].join(", ") unless params[0].empty?
    end
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_function name, function, html_options = {}
    message = t "message-link-to-function"
    ActiveSupport::Deprecation.warn message
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || '#'
    content_tag :a, name, html_options.merge(href: href, onclick: onclick)
  end

  def tab_active tab_name, current_tab
    current_tab == tab_name ? "active" : nil
  end

  def member_list members
    members.map {|member| link_to member.name, member}.join(", ").html_safe
  end

  def select_profile_field target, target_array, builder
    builder.select "#{target}_id".to_sym,
      options_for_select(target_array.collect {|t|
      [t.name, t.id ]}, builder.object.send("#{target}_id")),
      {include_blank: true}, class: "form-control"
  end

  def avatar_user_tag user, class_name, avatar_size
    image_tag user.avatar_url ? user.avatar_url : "profile.png",
      class: class_name.to_sym, size: avatar_size
  end

  def set_image object, size = Settings.image_size_100, class_name = "img-circle"
    image_tag object.image_url ? object.image_url : "no_image", size: size, class: class_name
  end

  def image_course_tag course, language, size = Settings.image_size_100, class_name = "img-circle"
    image_tag course.image_url ? course.image_url : language, size: size,
      class: class_name
  end

  def image_object chat_room
    if chat_room.class.name == "User"
      avatar_user_tag chat_room, "img-circle",
        Settings.image_size_40
    elsif chat_room.class.name == "Course"
      image_course_tag chat_room, "img-circle",
        Settings.image_size_40
    end
  end

  def set_color_status status
    "#{status}-color"
  end

  def set_background_color_status status
    "#{status}-background-color"
  end

  def set_border_status status
    "#{status}-border-color"
  end

  def add_breadcrumb_path resource
    add_breadcrumb t("breadcrumbs.#{resource}.all"),
      "#{@namespace}_#{resource}_path".to_sym
  end

  def add_breadcrumb_index resource
    add_breadcrumb t "breadcrumbs.#{resource}.all"
  end

  def add_breadcrumb_new resource
    add_breadcrumb t "breadcrumbs.#{resource}.new"
  end

  def add_breadcrumb_edit resource
    add_breadcrumb t "breadcrumbs.#{resource}.edit"
  end

  def add_breadcrumb_subject_task_masters
    add_breadcrumb t("breadcrumbs.subjects.task_masters")
  end

  def add_breadcrumb_subject_new_task
    add_breadcrumb t("breadcrumbs.subjects.new_task")
  end

  def add_breadcrumb_role_allocate_permissions
    add_breadcrumb t "breadcrumbs.roles.allocate_permissions"
  end

  def i18n_enum model_name, enum
    enum = enum.to_s.pluralize
    model_name = model_name.to_s
    model_name.classify.constantize.public_send(enum).keys.map do |key|
      OpenStruct.new key: key, value: I18n.t("#{model_name.pluralize}.#{enum}.#{key}")
    end.flatten
  end

  def percentage_format number
    number_to_percentage number, precision: 1, strip_insignificant_zeros: true
  end

  def chat_type room
    chat_room = room.class.name
    chat_room == User.name ? Conversation.name : chat_room
  end

  def allow_render_message message, active_room
    message.chat_room_type == Conversation.name && active_room.to_i != current_user.id
  end

  def unseen_number current_user, chat_room
    chat_room = Conversation.existing_conversation(
      chat_room.id, current_user.id).first if chat_room.class.name == "User"

    count = 0
    count = chat_room.messages.unread_by(current_user).size if chat_room
    count > 0 ? count : nil
  end

  def class_body name
    name == "static_pages" || name == "sessions" ?
      "body_home" : "container body-wrapper-content"
  end

  def progressbar_color percent
    if percent < 40
      "progress-bar-info"
    elsif percent < 60
      "progress-bar-success"
    elsif percent < 80
      "progress-bar-warning"
    else
      "progress-bar-danger"
    end
  end
end
