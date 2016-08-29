class Trainer::TaskMastersController < ApplicationController
  load_resource :subject
  def index
    @task_masters = @subject.task_masters

    add_breadcrumb_path "subjects"
    add_breadcrumb @subject.name
    add_breadcrumb_subject_task_masters
  end
end
