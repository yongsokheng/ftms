class Trainer::EvaluationTemplatesController < ApplicationController
  load_and_authorize_resource

  def index
    @evaluation_template = EvaluationTemplate.new
    respond_to do |format|
      format.html {add_breadcrumb_index "evaluation_templates"}
      format.json {
        render json: EvaluationTemplatesDatatable.new(view_context, @namespace)
      }
    end
  end

  def new
    add_breadcrumb_path "evaluation_templates"
    add_breadcrumb_new "evaluation_templates"
  end

  def edit
    add_breadcrumb_path "evaluation_templates"
    add_breadcrumb @evaluation_template.name
    add_breadcrumb_edit "evaluation_templates"
  end

  def create
    if @evaluation_template.save
      flash[:success] = flash_message "created"
      redirect_to trainer_evaluation_templates_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def update
    if @evaluation_template.update_attributes evaluation_template_params
      flash[:success] = flash_message "updated"
      redirect_to trainer_evaluation_templates_path
    else
      flash_message[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @evaluation_template.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to :back
  end

  private
  def evaluation_template_params
    params.require(:evaluation_template).permit EvaluationTemplate::ATTRIBUTES_PARAMS
  end
end
