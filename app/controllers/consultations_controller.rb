class ConsultationsController < ApplicationController
  # アイデア相談の詳細画面を表示する(相談を受けたユーザーのみ)
  def show
    @consultation = Consultation.find(params[:id])
    @requester = User.find(@consultation.requester_id)
  end

  # アイデア相談の依頼画面を表示する
  def new
    @user = User.find(params[:user_id])
    @consultation = Consultation.new
    @answer_deadlines = (1..30).map do |day|
      ["#{day}日後(#{(Time.current + day.days).strftime('%Y年%m月%d日中')})", (Time.current + day.days)]
    end
  end

  # アイデア相談を依頼する
  def create
    @user = User.find(params[:user_id])
    @consultation = Consultation.new(consultation_params.merge(consultant: @user, request_status: :requesting))

    if @consultation.save
      # 保存成功時の処理
      redirect_to root_path, notice: 'アイデア相談を依頼しました'
    else
      # 保存失敗時の処理
      render :new, alert: 'アイデア相談の依頼に失敗しました'
    end
  end

  # アイデア相談の依頼を受ける
  def accept
    @consultation = Consultation.find(params[:id])
    @consultation.update(request_status: 'completed', talkroom_status: 'opened')
    redirect_to root_path, notice: '依頼を受けました'
  end

  # アイデア相談の依頼を断る
  def reject
    @consultation = Consultation.find(params[:id])
    @consultation.update(request_status: 'completed', talkroom_status: 'closed')
    redirect_to root_path, notice: '依頼を断りました'
  end

  # アイデア相談依頼の受付一覧を表示する
  def received_consultations
    @consultations = Consultation.includes(:requester).where(consultant: current_user)
  end

  private

  # ストロングパラメーター
  def consultation_params
    params.require(:consultation).permit(:request_content, :answer_deadline).merge(requester_id: current_user.id)
  end
end
