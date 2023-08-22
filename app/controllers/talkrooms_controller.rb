class TalkroomsController < ApplicationController
  # 作成されたトークルーム一覧を表示する
  def index
    @consultations = Consultation.includes(:requester, :consultant)
      .where('requester_id = ? OR consultant_id = ?', current_user.id, current_user.id)
      .where.not(talkroom_status: :not_created)
  end

  # トークルームに入り､メッセージを既読にする
  def show
    @consultation = Consultation.find(params[:consultation_id])
    # トークルームに紐づくメッセージをまとめて取得する(N+1問題を解消するためにincludesメソッドを使用)
    @messages = @consultation.messages.includes(:sender)
    # 受信したメッセージに未読があれば既読にする
    unread_messages = @messages.where.not(sender: current_user, is_read: false)
    unread_messages.update_all(is_read: true) if unread_messages.exists?
  end

  def end_consultation
    consultation = Consultation.find(params[:consultation_id])
    consultation.update(talkroom_status: :closed)
    redirect_to root_path, notice: 'アイデア相談を終了しました'
  end
end
