class EvaluationTemplatesDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @namespace = namespace
    @view = view
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: EvaluationTemplate.count,
      iTotalDisplayRecords: evaluation_templates.total_count,
      aaData: data
    }
  end

  private
  def data
    evaluation_templates.map.each.with_index 1 do |evaluation_template, index|
      [
        index,
        evaluation_template.name,
        evaluation_template.min_point,
        evaluation_template.max_point,
        link_to(@view.t("button.edit"),
          eval("@view.edit_#{@namespace}_evaluation_template_path(evaluation_template)"),
          class: "text-primary pull-right"),
        link_to(@view.t("button.delete"),
          eval("@view.#{@namespace}_evaluation_template_path(evaluation_template)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def evaluation_templates
    @evaluation_templates ||= fetch_evaluation_templates
  end

  def fetch_evaluation_templates
    @evaluation_templates = EvaluationTemplate.order "#{sort_column} #{sort_direction}"
    evaluation_templates = @evaluation_templates.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      evaluation_templates = evaluation_templates.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    evaluation_templates
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @evaluation_templates.size
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
