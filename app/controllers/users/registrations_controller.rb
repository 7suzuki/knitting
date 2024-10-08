# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    @user = current_user
  end

  # PUT /resource
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_users_path notice: "プロフィールが更新されました"
    else
      flash.now[:alert] = "プロフィールの更新に失敗しました"
      render :edit
    end
  end

  # DELETE /resource
  def destroy
    user = current_user
    user.update!(is_active: false)
    reset_session #ログアウトさせる
    redirect_to root_path, notice: "退会しました"
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def after_sign_in_path_for(resource)
    mypage_users_url
  end

  def user_params
    params.require(:user).permit(:name, :comment)
  end

  def ensure_guest_user
    if current_user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
