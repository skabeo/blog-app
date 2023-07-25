require 'rails_helper'

RSpec.feature 'User Post Index', type: :feature do
  before(:all) do
    @user = User.first
  end

  scenario "I can see the post's title" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario "I can see who wrote the post" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content(@user.name)
    end
  end

  scenario "I can see how many comments it has" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content("Comments: #{post.comments.count}")
    end
  end

  scenario "I can see how many likes it has" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content("Likes: #{post.likes.count}")
    end
  end

  scenario "I can see the post body" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  scenario "I can see the username of each commentor" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      post.comments.each do |comment|
        expect(page).to have_content("Post by #{comment.author.name}")
      end
    end
  end

  scenario "I can see the comment each commentor left" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
