class Public::RelationshipsController < PublicController
  before_action :authenticate_user!
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
		redirect_to request.referer #HTTPリクエストのリファラ（参照元）URLを返す
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
		redirect_to request.referer
  end
  
  def followings
    user = User.find(params[:user_id])
		@users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
		@users = user.followers
  end
  
end
