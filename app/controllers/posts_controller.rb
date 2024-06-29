class PostsController < ApplicationController

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post.id)
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
    @user = current_user
    # キーワード検索
    if params[:body].present?
      @posts = @posts.where(body: params[:body]) # 完全一致
      # @posts = @posts.where("body LIKE ?", "%#{params[:body]}%") # 曖昧検索もwhereを使う
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path (post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "投稿が削除されました"
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end
end
