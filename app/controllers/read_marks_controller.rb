class ReadMarksController < ApplicationController
  def update
    message = Message.find params[:id]
    message.mark_as_read! for: current_user
    render nothing:true, status: 200 
  end
end
