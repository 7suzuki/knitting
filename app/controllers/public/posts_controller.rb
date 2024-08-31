class Public::PostsController < PublicController
  before_action :authenticate_user!
  before_action :author_only!, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.active_user_only.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all.active_user_only.includes(:user).left_joins(:post_comments).group("posts.id").select("COUNT(post_comments.id) AS post_comment_count", "posts.*")
    if params[:body].present?
      @posts = @posts.search_by_body(params[:body].to_s)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿が更新されました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿が削除されました"
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end

  def author_only!
    post = Post.find(params[:id])
    if post.user != current_user
      redirect_to posts_path, alert: "他のユーザーの投稿は編集できません"
    end
  end
end
