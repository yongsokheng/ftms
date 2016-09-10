class RolesDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @namespace = namespace
    @view = view
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Role.count,
      iTotalDisplayRecords: roles.total_count,
      aaData: data
    }
  end

  private
  def data
    roles.map.each.with_index 1 do |role, index|
      [
        index,
        link_to(role.name, eval("@view.edit_admin_role_allocate_permissions_path(role)")),
        link_to(@view.t("button.edit"), eval("@view.edit_#{@namespace}_role_path(role)"),
          class: "text-primary pull-right"),
        link_to(@view.t("button.delete"), eval("@view.#{@namespace}_role_path(role)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def roles
    @roles ||= fetch_roles
  end

  def fetch_roles
    @roles = Role.not_admin.order "#{sort_column} #{sort_direction}"
    roles = @roles.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      roles = roles.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    roles
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @roles.size
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
