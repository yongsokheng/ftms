class UniversitiesDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @view = view
    @namespace = namespace
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: University.count,
      iTotalDisplayRecords: universities.total_count,
      aaData: data
    }
  end

  private
  def data
    universities.map.each.with_index 1 do |university, index|
      [
        index,
        university.name,
        link_to(@view.t("button.edit"), eval("@view.edit_#{@namespace}_university_path(university)"),
          class: "text-primary pull-right"),
        link_to(@view.t("button.delete"), eval("@view.#{@namespace}_university_path(university)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def universities
    @universities ||= fetch_universities
  end

  def fetch_universities
    @universities = University.order "#{sort_column} #{sort_direction}"
    universities = @universities.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      universities = universities.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    universities
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @universities.size
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
