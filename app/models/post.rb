class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
