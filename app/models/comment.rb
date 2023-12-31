class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true, length: { maximum: 250 }

  after_create :increment_post_comment_counter
  before_destroy :decrease_comment_counter

  def increment_post_comment_counter
    post.increment!(:comment_counter)
  end

  def decrease_comment_counter
    post.decrement!(:comment_counter)
  end
end
