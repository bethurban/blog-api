require 'rails_helper'
require 'pry'

RSpec.describe 'Authentication', type: :request do

  #Authentication test suite
  describe 'POST /auth/login' do
    #Create test user
    let!(:user) { create(:user) }
    #Set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    #Set test valid and invalid credentials
    let(:valid_credentials) do
      {
        name: user.name,
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        name: Faker::Movies::StarWars.character,
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    #Set request.headers to our custom headers
    #before { allow(request).to receive(:headers).and_return(headers) }

    #Returns auth token when request is valid
    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    #Returns failure message when request is invalid
    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end

  end

end
