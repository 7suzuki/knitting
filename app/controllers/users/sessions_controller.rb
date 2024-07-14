# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  private
  # アクティブであるかを判断するメソッド
  def user_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    user = User.find_by(name: params[:user][:name])
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if user.nil?
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
    # 【処理内容4】 アクティブでない会員に対する処理
    if user.is_active == false
      flash[:alert] = "このアカウントは退会済みです。"
      redirect_to root_path and return
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
