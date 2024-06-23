class Admin::UsersController < ApplicationController
  def destroy
    user = User.find(params[:id])
    user.update!(is_active: false)
    redirect_to admin_users_path, notice: "#{user.name}を退会させました"
  end
end
