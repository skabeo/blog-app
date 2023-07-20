class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author_id = current_user.id
    @like.post_id = params[:id]

    if @like.save
      @post = @like.post
      redirect_to user_post_details_path
    else
      render :new
    end
  end
end
