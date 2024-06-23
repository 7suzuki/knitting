class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def mypage
    @user = current_user
    render :show
  end
  
  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
  end
  
  def update
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
    @user.update(user_params)
    redirect_to mypage_users_path
  end
  
  def destroy　#editに入れたほうがいいかも？
    @user = current_user
    user.update!(is_active: false)
    redirect_to user_path, notice: "退会しました"
  end
  
end
