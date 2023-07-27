class Api::CommentsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments
    render json: comments.to_json(only: [:id, :text, :created_at, :updated_at, :comments_counter, :likes_counter])
  end
end
