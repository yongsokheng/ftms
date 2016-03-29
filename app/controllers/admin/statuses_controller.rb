class Admin::StatusesController < ApplicationController
  load_and_authorize_resource except: :show

  def index
    @status = Status.new
  end

  def new
  end

  def create
    if @status.save
      flash[:success] = flash_message "created"
      redirect_to admin_statuses_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
  end

  def update
    if @status.update_attributes status_params
      flash[:success] = flash_message "updated"
      redirect_to admin_statuses_path
    else
      flash_message[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @status.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to :back
  end

  private
  def status_params
    params.require(:status).permit Status::ATTRIBUTES_PARAMS
  end
end
