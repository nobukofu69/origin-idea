class ConsultationsController < ApplicationController
  def new
  end

  def create
  end
end

rails g model cosultation consultant_id:integer requester_id:integer request_content:text answer_deadline:datetime status:string is_read:boolean talk_room_status:string