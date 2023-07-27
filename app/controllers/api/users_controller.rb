class Api::UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users.to_json(only: [:id, :name, :photo, :bio, :created_at, :updated_at, :posts_counter])
  end
end
