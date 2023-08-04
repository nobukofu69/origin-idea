class ConsultationsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @consultation = Consultation.new
    @answer_deadlines = (1..30).map do |day|
      [ "#{day}日後(#{(Time.current + day.days).strftime('%Y年%m月%d日')})", (Time.current + day.days) ]
    end
  end

  def create
    @user = User.find(params[:user_id])
    @consultation = Consultation.new(consultation_params.merge(consultant: @user, status: :requesting))

    if @consultation.save
      # 保存成功時の処理
      redirect_to root_path, notice: 'コンサル依頼が完了しました'
    else
      # 保存失敗時の処理
      render :new
    end
  end

  # ユーザーが受けたコンサル依頼一覧を表示する
  def received_consultations
    @consultations = Consultation.where(consultant: current_user)
  end

  private

  def consultation_params
    params.require(:consultation).permit(:request_content, :answer_deadline).merge(requester_id: current_user.id)
  end
end