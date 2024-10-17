class Admin::UsersController < AdminController
  before_action :authenticate_admin_user!
  
  def index
    @users = User.all
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def destroy #会員機能を論理削除する＝退会処理
    user = User.find(params[:id])
    user.update!(is_active: false)
    redirect_to admin_users_path, notice: "#{user.name}を退会させました"
  end
  
  def reactivate #会員機能を有効に戻す
    user = User.find(params[:id])
    user.update!(is_active: true)
    redirect_to admin_users_path, notice: "#{user.name}を有効"
  end
  
end

