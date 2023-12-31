class Api::CommentsController <
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments
    render json: comments.to_json(only: %i[id text created_at updated_at comments_counter likes_counter])
  end

  def create
    post = Post.find(params[:post_id])
    user = User.find(params[:user_id])
    comment = post.comments.build(comment_params)
    comment.author_id = user.id

    if comment.save
      render json: comment, status: :created
    else
      render json: { error: comment.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
