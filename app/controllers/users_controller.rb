class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # current_userが@userに対して相談中またはトークルームを作成済みの場合､trueを返す
    @already_requested = Consultation.where(requester: current_user,
      consultant: @user, request_status: :requesting, talkroom_status: :opened).exists?
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: 'プロフィールを更新しました'
    else
      render :edit, alert: 'プロフィールの更新に失敗しました'
    end
  end

  def toggle_consultant_status
    @user = User.find(params[:id])
    @user.update(is_consultant: !@user.is_consultant)
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit(:birth_date, :gender, :profession, :profile, :skill)
  end

end
