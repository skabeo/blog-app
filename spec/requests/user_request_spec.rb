require 'rails_helper'

RSpec.describe User, type: :request do
  describe '#user' do
    it 'should render the user index' do
      get '/users'
      expect(response.status).to eq(200)
      expect(response).to render_template('users/index')
      expect(response.body).to include 'Here is a list of users'
    end

    it 'should render the user show' do
      get '/users/1'
      expect(response.status).to eq(200)
      expect(response).to render_template('users/show')
      expect(response.body).to include 'Here is a list of post for a user'
    end
  end
end
