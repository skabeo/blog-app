class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def all_comments
    comments.order(created_at: :asc)
  end

  def update_likes_counter
    update(likes_counter: likes.where(post_id: id).count)
  end
end
