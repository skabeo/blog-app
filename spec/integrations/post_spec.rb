require 'rails_helper'

RSpec.feature 'User Post Index', type: :feature do
  before(:all) do
    @user = User.first
  end
  scenario 'should display users posts index page' do
    visit user_post_path(@user.id)

    puts @user.id
    expect(page).to have_selector('.user-img')
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.posts_counter)
    @user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
      expect(page).to have_button(text: 'Add a post')
    end
  end

  scenario 'should display post page' do
    visit user_post_path(@user)

    @user.posts.each do |post|
      find('a', text: post.title).click
      expect(page).to have_current_path(user_post_details_path(user_id: @user.id, id: post.id))
      expect(page).to have_content(post.title)
      expect(page).to have_content("Post by #{@user.name}")
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
      expect(page).to have_content(post.text)

      post.comments.each do |comment|
        expect(page).to have_content("Post by #{comment.author.name}")
        expect(page).to have_content(comment.text)
      end
    end
  end
end
