class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # current_userが@userに対して相談中またはトークルームを作成済みの場合､trueを返す
    @already_requested = Consultation.where(requester: current_user,
      consultant: @user, request_status: :requesting, talkroom_status: :opened).exists?
  end

  def edit
  end

  def toggle_consultant_status
    @user = User.find(params[:id])
    @user.update(is_consultant: !@user.is_consultant)
    redirect_to @user
  end


end
