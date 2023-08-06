# app/controllers/talkrooms_controller.rb
class TalkroomsController < ApplicationController
  def index
    @consultations = Consultation.includes(:requester, :consultant).where(status: [2, 3])
      .where("requester_id = ? OR consultant_id = ?", current_user.id, current_user.id)
  end

  def show
    @consultation = Consultation.find(params[:consultation_id])
  end
end