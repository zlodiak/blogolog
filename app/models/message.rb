class Message < ActiveRecord::Base
  validates :body, presence: true, length: { maximum:  600, minimum: 10 }
end
