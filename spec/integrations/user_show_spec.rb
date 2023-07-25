require 'rails_helper'

RSpec.describe 'user show page', type: :feature do
  scenario 'visible profile picture' do
    user = User.create(name: 'Spencer', posts_counter: 5)
    visit user_show_path(user.id)
    expect(page).to have_css("img.user-img")
  end

  scenario 'visible username' do
    user = User.create(name: 'Spencer', posts_counter: 5)
    visit user_show_path(user.id)
    expect(page).to have_content(user.name)
  end

  scenario 'can see number of posts' do
    user = User.create(name: 'Spencer', posts_counter: 5)
    visit user_show_path(user.id)
    expect(page).to have_content(user.posts_counter)
  end

  scenario 'can see user\'s bio' do
    user = User.create(name: 'Spencer', bio: 'I\'m him', posts_counter: 5)
    visit user_show_path(user.id)
    expect(page).to have_content(user.bio)
  end

  scenario "displays the user's first 3 posts" do
    user = User.create(name: 'Spencer', bio: 'I\'m him', posts_counter: 5)

    post1 = Post.create(author_id: user.id, title: 'Greetings', text: 'Hello world', likes_counter: 5, comment_counter: 4)
    post2 = Post.create(author_id: user.id, title: 'Music', text: 'Rap is the goat of genre', likes_counter: 5, comment_counter: 4)
    post3 = Post.create(author_id: user.id, title: 'Fan fact', text: 'Your thigh bone is stonger than concreate',  likes_counter: 5, comment_counter: 4)

    visit user_show_path(user.id)

    expect(page).to have_content('Greetings')
    expect(page).to have_content('Hello world')

    expect(page).to have_content('Music')
    expect(page).to have_content('Rap is the goat of genre')

    expect(page).to have_content('Fan fact')
    expect(page).to have_content('Your thigh bone is stonger than concreate')
  end

  scenario 'see all posts button' do
    user = User.create(name: 'Spencer', bio: 'I\'m him', posts_counter: 5)
    visit user_show_path(user.id)
    expect(page).to have_content('See all posts')
  end

  scenario 'redirects to post show page' do
    user = User.create(name: 'Spencer', bio: 'I\'m him', posts_counter: 5)
    post1 = Post.create(author_id: user.id, title: 'Greetings', text: 'Hello world', likes_counter: 5, comment_counter: 4)
    visit user_show_path(user.id)
    click_on 'Greetings'
    expect(page).to have_current_path(user_post_details_path(user_id: user.id, id: post1.id))
  end

  scenario "redirects to user's post index page when clicking 'See all posts'" do
    user = User.create(name: 'Spencer', bio: "I'm him", posts_counter: 5)
    visit user_show_path(user.id)
    click_button 'See all posts'
    expect(page).to have_current_path(user_post_path(user.id))
  end
end