class Admin::PostsController < AdminController
  before_action :authenticate_admin_user!
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all
    @users = User.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿が削除されました"
  end
end
