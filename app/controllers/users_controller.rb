class UsersController < ApplicationController
 
  def show
    @user = User.find(params[:id])
    # ログインユーザーが@userに相談を依頼していない場合､インスタンス変数にtrueを代入する
    @not_consulted = Consultation.not_consulted?(current_user, @user)
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
