class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_unread_request_status, if: :user_signed_in?
  before_action :set_unread_message_status, if: :user_signed_in?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name birthdate gender])
  end

  # 未読の依頼があるかを確認し､その結果をインスタンス変数に格納する
  def set_unread_request_status
    @unread_request = Consultation.unread_request?(current_user)
  end

  # 未読のメッセージがあるかを確認し､その結果をインスタンス変数に格納する
  def set_unread_message_status
    @unread_message = Consultation.unread_message?(current_user)
  end
end
