class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
end
