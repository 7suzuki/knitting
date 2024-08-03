class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  has_many :posts
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  def active_status
    if is_active
      "入会"
    else
      "退会"
    end
  end
end

