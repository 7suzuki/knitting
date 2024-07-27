class Admin::PostCommentsController < AdminController
  
  def index
    @post_comments = PostComment.all
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_post_comments_path, notice: "投稿が削除されました"
  end

end