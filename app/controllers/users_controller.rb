class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # 既に依頼済みかどうかを判定する
    @already_requested = Consultation.where(requester: current_user, consultant: @user, status: [1, 2]).exists?
  end

  def edit
  end

  def toggle_consultant_status
    @user = User.find(params[:id])
    @user.update(is_consultant: !@user.is_consultant)
    redirect_to @user
  end


end
