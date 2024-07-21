class Admin::PostsController < AdminController
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
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "投稿が削除されました"
    else
      redirect_to posts_path, alert: "他のユーザーの投稿は削除できません"
    end
  end
end
