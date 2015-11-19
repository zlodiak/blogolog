class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  belongs_to :user_status
  has_many :post_likes
  has_many :comment_likes
  has_many :comments
end
