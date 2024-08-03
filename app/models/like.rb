class Like < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }
  validate :validate_cannot_like_own_post

  private

  def validate_cannot_like_own_post
    if user == post.user
      errors.add(:base, "自分の投稿にはいいねできません")
    end
  end
end
