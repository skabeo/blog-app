require 'rails_helper'

RSpec.describe Like, type: :model do
  @user = User.new(name: 'Bob', photo: 'My cool photo', bio: 'Passionate programmer')
  @first_post = Post.new(author: @user, title: 'Culture', text: 'How do you like your chicken?')
  subject { Like.new(author: @user, post: @first_post)}

  before { subject.save }

  it 'should have author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should have post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
