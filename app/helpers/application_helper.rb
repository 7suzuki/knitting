module ApplicationHelper
  def follow_btn(user)
    if current_user.following?(user)
      link_to "フォロー外す", user_relationships_path(user), method: :delete, class: "btn btn-info"
    else
      link_to "フォローする", user_relationships_path(user), method: :post, class: "btn btn-success"
    end
  end

  def post_image_or_default(image)
    url = image.attached? ? image : "no_image.jpg"
    image_tag url, size: "100x100"
  end
end
