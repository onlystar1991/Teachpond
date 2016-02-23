class Category < ActiveRecord::Base

  has_many :posts
  has_many :requests

  def record_count
    self.requests.length + self.posts.length
  end
end
