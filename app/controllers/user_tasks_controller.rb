class UserTasksController < ApplicationController
  load_and_authorize_resource

  def update
    @old_status = @user_task.status
    if @user_task.update_attributes status: UserTask.statuses[:finished]
      track_activity
      flash.now[:success] = flash_message "updated"
    else
      flash.now[:error] = flash_message "not_updated"
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def track_activity
    new_status = @user_task.status
    unless @old_status == new_status
      @user_task.create_activity key: "user_task.change_status",
        owner: current_user, parameters: {old_status: @old_status,
        new_status: new_status}
    end
  end
end
