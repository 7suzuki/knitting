class Public::LikesController < PublicController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    current_user.likes.create!(post_id: post.id)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: 100)
    if like.present?
      like.destroy
    end
    redirect_to post_path(post)
  end
end
