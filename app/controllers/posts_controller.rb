class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end
  
  def search
    @posts = Post.all
    if params[:body].present?
      # @posts = @posts.where(body: params[:body]) # 完全一致
      @posts = @posts.where("body LIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(params[:body].to_s)}%") # 曖昧検索
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to user_path alert: "他のユーザーの投稿は編集できません"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.update(post_params)
        redirect_to post_path(@post), notice: "投稿が更新されました"
      else
        render :edit
      end
    else
      redirect_to posts_path, alert: "他のユーザーの投稿は編集できません"
    end
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

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end

end
