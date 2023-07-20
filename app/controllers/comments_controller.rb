class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:id]
    if @comment.save
      flash[:success] = 'Your comment was created'
      redirect_to user_post_details_path
    else
      flash.now[:error] = @comment.errors.full_messages.join('<br>').html_safe
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end