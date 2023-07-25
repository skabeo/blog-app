require 'rails_helper'

RSpec.feature 'User Post Index', type: :feature do
  before(:all) do
    @user = User.first
  end

  scenario 'should display profile image' do
    visit user_post_path(@user.id)
    expect(page).to have_selector('.user-img')
  end

  scenario "I can see the user's username" do
    visit user_post_path(@user.id)
    expect(page).to have_content(@user.name)
  end

  scenario 'should display number of posts' do
    visit user_post_path(@user.id)
    expect(page).to have_content(@user.posts_counter)
  end

  scenario "I can see post's title" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario "I can see some of the post's body" do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  scenario 'I can see how many comments a post has' do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content("Comments: #{post.comments.count}")
    end
  end

  scenario 'I can see how many likes a post has' do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      expect(page).to have_content("Likes: #{post.likes.count}")
    end
  end

  scenario 'Can see Add a post button' do
    visit user_post_path(@user.id)
    expect(page).to have_button(text: 'Add a post')
  end

  scenario 'should redirect me to post show page' do
    visit user_post_path(@user.id)
    @user.posts.each do |post|
      find('a', text: post.title).click
      expect(page).to have_current_path(user_post_details_path(user_id: @user.id, id: post.id))
    end
  end
end
