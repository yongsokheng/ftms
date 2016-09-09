class LocationsDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @view = view
    @namespace = namespace
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Location.count,
      iTotalDisplayRecords: locations.total_count,
      aaData: data
    }
  end

  private
  def data
    locations.each_with_index.map do |location, index|
      manager = location.manager
      [
        index + 1,
        link_to(location.name, eval("@view.#{@namespace}_location_path(location)")),
        if location.manager.present?
          link_to(@view.avatar_user_tag(manager, "profile-user",
            Settings.image_size_20), eval("@view.#{@namespace}_user_path(manager)"),
            title: manager.name)
        end,
        link_to(@view.t("button.edit"),
          eval("@view.edit_#{@namespace}_location_path(location)"),
          class: "text-primary pull-right"),
        link_to(@view.t("button.delete"),
          eval("@view.#{@namespace}_location_path(location)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def locations
    @locations ||= fetch_locations
  end

  def fetch_locations
    locations = Location.order "#{sort_column} #{sort_direction}"
    locations = locations.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      locations = locations.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    locations
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
