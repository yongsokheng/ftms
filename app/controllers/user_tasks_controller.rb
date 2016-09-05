class UserTasksController < ApplicationController
  load_and_authorize_resource

  def update
    @old_status = @user_task.status
    if @user_task.update_attributes status: UserTask.statuses[:finished]
      track_activity
      task_statistic
      flash.now[:success] = flash_message "updated"
      load_chart_data
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

  def task_statistic
    user_tasks = @user_task.user_subject.user_tasks
    @number_of_task = user_tasks.size
    @task_statuses = UserTask.statuses
    @task_statuses.each do |key, value|
      instance_variable_set "@number_of_task_#{key}", user_tasks.send(key).size
    end
  end

  def load_chart_data
    @user_subject = @user_task.user_subject
    @user_tasks_chart_data = {}

    @user_subject.course_subject.user_subjects.each do |user_subject|
      @user_tasks_chart_data[user_subject.user.name] = user_subject.user_tasks.finished.size
    end
  end
end
