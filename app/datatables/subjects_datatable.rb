class SubjectsDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @view = view
    @namespace = namespace
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Subject.count,
      iTotalDisplayRecords: subjects.total_count,
      aaData: data
    }
  end

  private
  def data
    subjects.map.each.with_index 1 do |subject, index|
      [
        index,
        link_to(subject.name, eval("@view.#{@namespace}_subject_task_masters_path(subject)")),
        subject.description
      ]
    end
  end

  def subjects
    @subjects ||= fetch_subjects
  end

  def fetch_subjects
    @subjects = Subject.order "#{sort_column} #{sort_direction}"
    subjects = @subjects.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      subjects = subjects.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    subjects
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @subjects.size
  end

  def sort_column
    columns = %w[id name description]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
