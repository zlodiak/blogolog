class Post < ActiveRecord::Base
  belongs_to :post_status
  belongs_to :user
  has_many :post_likes

  validates :title, presence: true, length: { maximum:  600, minimum: 3 }
  validates :body, presence: true, length: { maximum:  60000, minimum: 100 }
end
