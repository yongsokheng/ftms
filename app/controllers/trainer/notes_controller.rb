class Trainer::NotesController < ApplicationController
  load_and_authorize_resource

  before_action :load_notes, only: [:create, :update, :destroy]

  def create
    @note.author_id = current_user.id
    if @note.save
      flash.now[:success] = flash_message "created"
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @note.update_attributes note_params
      flash.now[:success] = flash_message "updated"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @note.destroy
      flash.now[:success] = flash_message "deleted"
    else
      flash.now[:failed] = flash_message "not_deleted"
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def note_params
    params.require(:note).permit Note::ATTRIBUTES_PARAMS
  end

  def load_notes
    user_id = @note.user_id
    @notes = Note.load_notes user_id, current_user
  end
end
