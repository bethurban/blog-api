require 'rails_helper'

RSpec.describe AuthorizeApiRequest do

  #Create test user
  let(:user) { create(:user) }

  #Mock 'Authorization' header
  let(:header) { { 'Authorization' => token_generator(user.id) } }

  #Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }

  #Valid request subject
  subject(:request_obj) { described_class.new(header) }

  #Test suite for AuthorizeApiRequest#call
  #Entry point into the service class
  describe '#call' do
    #Returns user object when request is valid
    context 'when valid request' do
      it 'returns user object' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    #Returns error message when request is invalid
    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          #custom helper method `token_generator`
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end
    end

  end

end
