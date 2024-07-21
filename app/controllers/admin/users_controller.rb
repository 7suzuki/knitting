class Admin::UsersController < AdminController
  def index
    @users = User.all
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def destroy
    user = User.find(params[:id])
    user.update!(is_active: false)
    redirect_to admin_users_path, notice: "#{user.name}を退会させました"
  end
end

