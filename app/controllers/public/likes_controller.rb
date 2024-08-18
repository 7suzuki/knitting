class Public::LikesController < PublicController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)
    unless like.save
      flash[:alert] = like.errors.full_messages.join(", ")
    end
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to post_path(post)
  end
  
  def index
  
  end
end
