class Public::UsersController < PublicController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def mypage
    @user = current_user
    @posts = @user.posts
    render :show
  end

  def like
    @user = User.find(params[:user_id])
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
end

