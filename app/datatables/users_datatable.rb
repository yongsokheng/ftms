class UsersDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @namespace = namespace
    @view = view
    @current_user = @view.current_user
    @trainees = User.trainees
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: users.total_count,
      iTotalDisplayRecords: users.total_count,
      aaData: data
    }
  end

  private
  def data
    users.includes(:roles).map.each.with_index 1 do |user, index|
      [
        index,
        link_to(user.name, eval("@view.#{@namespace}_user_path(user)")),
        user.email,
        user.roles.map(&:name).join(", "),
        link_to(@view.t("button.edit"), eval("@view.edit_#{@namespace}_user_path(user)"), class: "pull-right"),
        link_to(@view.t("button.delete"), eval("@view.#{@namespace}_user_path(user)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    if @current_user.is_admin? && @namespace == Settings.namespace_roles.admin
      @users = User.select_all
    else
      courses = @current_user.user_courses.pluck :course_id
      @users = @trainees.find_course courses
    end
    users = @users.order("#{sort_column} #{sort_direction}")
      .per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      users = users.where "users.name like :search", search: "%#{params[:sSearch]}%"
    end
    users
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @users.size
  end

  def sort_column
    columns = %w[id name email]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
