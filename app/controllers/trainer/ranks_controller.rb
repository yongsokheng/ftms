class Trainer::RanksController < ApplicationController
  load_and_authorize_resource

  def index
    @rank = Rank.new
    respond_to do |format|
      format.html {add_breadcrumb_index "ranks"}
      format.json {
        render json: RanksDatatable.new(view_context, @namespace)
      }
    end
  end

  def new
    add_breadcrumb_path "ranks"
    add_breadcrumb_new "ranks"
  end

  def create
    if @rank.save
      flash[:success] = flash_message "created"
      redirect_to trainer_ranks_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
    add_breadcrumb_path "ranks"
    add_breadcrumb @rank.rank_value
    add_breadcrumb_edit "ranks"
  end

  def update
    if @rank.update_attributes rank_params
      flash[:success] = flash_message "updated"
      redirect_to trainer_ranks_path
    else
      flash_message[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @rank.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to :back
  end

  private
  def rank_params
    params.require(:rank).permit Rank::ATTRIBUTES_PARAMS
  end
end
