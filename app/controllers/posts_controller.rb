class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.likes_counter = 0
    @post.comment_counter = 0

    if @post.save
      flash[:success] = 'Your post was sent'
      redirect_to users_path
    else
      flash.now[:error] = @post.errors.full_messages.join('<br>').html_safe
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post

    if @post.destroy
      flash[:success] = 'Post successfully deleted.'
    else
      flash[:error] = 'Failed to delete the post.'
    end
    redirect_to user_post_path(@post.author_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
