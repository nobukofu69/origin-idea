class HomeController < ApplicationController
  def index
    # ユーザーログインしていない場合､全ユーザーを表示するガード節
    unless user_signed_in?
      @users = User.all
      return
    end

    # ユーザーがゲストユーザーの場合､インスタンス変数にゲストユーザーを代入する
    if current_user.guest_user?
      @user = current_user
    else # ユーザーがゲストユーザーでない場合､インスタンス変数に自分以外のユーザーを代入する
      @users = User.where.not(id: current_user.id)
    end
  end
end
