class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  scope :search_by_body, -> (body) { where("body LIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(body)}%") }# 曖昧検索
  scope :active_user_only, -> { joins(:user).where(users: { is_active: true }) }

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
