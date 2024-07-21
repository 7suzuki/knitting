class Admin::PostCommentsController < AdminController
  
  def index
    @postComments = PostComment.all
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

end