require 'rails_helper'

RSpec.describe Post, type: :model do
  spencer = User.new(name: 'Spencer Okyere', photo: 'Cool photo', bio: 'Spec the programmer', posts_counter: 0)
  subject { Post.new(author: spencer, title: 'Music', text: 'Kendrick Lamar is the GOAT', likes_counter: 1) }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comment_counter should be an integer' do
    subject.comment_counter = 'try'
    expect(subject).to_not be_valid
  end

  it 'comment_counter should have no negative values' do
    subject.comment_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = true
    expect(subject).to_not be_valid
  end

  it 'likes_counter should have no negative values' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should save correctly' do
    subject.comment_counter = 0
    expect(subject).to be_valid
  end

  it 'should have an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should return a users last 5 comment' do
    user = User.create(name: 'Spencer Okyere', photo: 'Link to photo', bio: 'Hello World', posts_counter: 10)
    post = Post.create(title: 'Random title', text: 'Hello, world', author_id: user.id, likes_counter: 0,
                       comment_counter: 0)
    6.times.collect do
      Comment.create(
        author: user,
        post:,
        text: 'Test post'
      )
    end
    expect(post.recent_comments.length).to eq(5)
  end

  it 'updates the posts_counter attribute of the author' do
    author = User.create(name: 'John Doe')
    post = Post.create(title: 'Test Post', author:)
    expect(post.update_post_counter).to be(true)
  end
end
