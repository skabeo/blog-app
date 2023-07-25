require 'rails_helper'

RSpec.describe 'user index page', type: :feature do
  scenario 'i can see username of all other users' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  scenario 'i can see the number of posts' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content(user.posts_counter)
    end
  end

  scenario 'redirect to user\'s show page' do
    visit users_path
    user = User.find(101)
    click_on 'Spencer'
    expect(page).to have_current_path(user_show_path(user.id))
  end
end
