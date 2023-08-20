class HomeController < ApplicationController
  def top
    if user_signed_in?
      redirect_to home_path
    end
  end

  def index
    # ユーザーログインしていない場合､全ユーザー(ゲストユーザー以外)を表示するガード節
    unless user_signed_in?
      @users = User.where.not(email: 'guest@example.com')
      return
    end

    # ユーザーがゲストユーザーの場合､インスタンス変数にゲストユーザーを代入する
    if current_user.guest_user?
      @user = current_user
    else # ユーザーがゲストユーザーでない場合､インスタンス変数に自分とゲスト以外のユーザーを代入する
      @users = User.where.not('id = ? OR email = ?', current_user.id, 'guest@example.com')
    end
  end
end
