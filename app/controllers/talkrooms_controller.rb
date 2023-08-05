# app/controllers/talkrooms_controller.rb
class TalkroomsController < ApplicationController
  def index
    @consultations = Consultation.includes(:requester, :consultant).where(status: [2, 3])
  end

  def show
  end
end