class PostsController < ApplicationController
  def index
    @posts = Post.all

    if params[:body].present?
      @posts = @posts.where(body: params[:body])
    end
  end

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

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def post_params
    params.require(:post).permit(:body)
  end
end
