class RanksDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @namespace = namespace
    @view = view
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Rank.count,
      iTotalDisplayRecords: ranks.total_count,
      aaData: data
    }
  end

  private
  def data
    ranks.map.each.with_index 1 do |rank, index|
      [
        index,
        rank.rank_value,
        rank.begin_point,
        rank.end_point,
        link_to(@view.t("button.edit"), eval("@view.edit_#{@namespace}_rank_path(rank)"),
          class: "text-primary pull-right"),
        link_to(@view.t("button.delete"), eval("@view.#{@namespace}_rank_path(rank)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def ranks
    @ranks ||= fetch_ranks
  end

  def fetch_ranks
    @ranks = Rank.order "#{sort_column} #{sort_direction}"
    ranks = @ranks.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      ranks = ranks.where "rank_value like :search", search: "%#{params[:sSearch]}%"
    end
    ranks
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @ranks.size
  end

  def sort_column
    columns = %w[id rank_value]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
