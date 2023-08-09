class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # current_userが@userに対してコンサル依頼を送っている場合､@already_requestedをtrueにする
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
