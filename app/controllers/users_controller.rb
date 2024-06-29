class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def mypage
    @user = current_user
    @posts = @user.posts
    render :show
  end
  
  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.id != current_user.id
      redirect_to user_path(current_user) and return
    end
    
    if @user.update(user_params)
      redirect_to mypage_users_path notice: "プロフィールが更新されました"
    else
      render :edit, alert: "プロフィールの更新に失敗しました"
    end
  end
  
  def destroy　#editに入れたほうがいいかも？
    @user = current_user
    user.update!(is_active: false)
    redirect_to user_path, notice: "退会しました"
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :comment)
  end
  
end

