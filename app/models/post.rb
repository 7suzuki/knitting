class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_one_attached :image
  
  validates :body, presence: true
  
end
