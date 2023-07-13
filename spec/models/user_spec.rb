require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Spencer Okyere', photo: 'Link to photo', bio: 'Hello World', posts_counter: 10) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should not allow non integer value' do
    subject.posts_counter = 'he'
    expect(subject).to_not be_valid
  end

  it 'should not include negative values' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should be valid' do
    expect(subject).to be_valid
  end
end
