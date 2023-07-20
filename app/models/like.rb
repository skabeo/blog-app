class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :increment_likes_comment_counter

  def increment_likes_comment_counter
    post.increment!(:likes_counter)
  end
end
