class TalkroomsController < ApplicationController
  # 作成されたトークルーム一覧を表示する
  def index
    @consultations = Consultation.includes(:requester, :consultant)
                                 .where('requester_id = ? OR consultant_id = ?', current_user.id, current_user.id)
                                 .where.not(talkroom_status: :not_created)
  end

  # トークルームに入る
  def show
    @consultation = Consultation.find(params[:consultation_id])
    @messages = @consultation.messages.includes(:sender)
  end

  def end_consultation
    consultation = Consultation.find(params[:consultation_id])
    consultation.update(talkroom_status: :closed)
    redirect_to root_path, notice: 'アイデア相談を終了しました'
  end
end
