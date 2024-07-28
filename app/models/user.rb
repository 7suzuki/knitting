class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  has_many :posts
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def active_status
    if is_active
      "入会"
    else
      "退会"
    end
  end
end

