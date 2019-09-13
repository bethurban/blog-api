require 'rails_helper'

RSpec.describe 'Blogs API', type: :request do
  #Initialize test data
  let(:user) { create(:user) }
  let!(:blogs) { create_list(:blog, 10, created_by: user.id) }
  let(:blog_id) { blogs.first.id }

  #Authorize request
  let(:headers) { valid_headers }

  #Test suite for GET /blogs
  describe 'GET /blogs' do
    #Make HTTP request before each example
    before { get '/blogs' }

    it 'returns blogs' do
      #'json' is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    #Test suite for GET /blogs/:id
    describe 'GET /blogs/:id' do
      before { get "/blogs/#{blog_id}" }

      context 'when the record exists' do
        it 'returns the blog' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(blog_id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        let(:blog_id) { 100 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not-found message' do
          expect(response.body).to match(/Couldn't find Blog/)
        end
      end
    end

    #Test suite for POST /blogs
    describe 'POST /blogs' do
      #Valid payload
      let(:valid_attributes) do
        { title: 'My Blog', created_by: user.id.to_s }.to_json
      end

      context 'when the request is valid' do
        before { post '/blogs', params: valid_attributes, headers: headers }

        it 'creates a blog' do
          expect(json['title']).to eq('My Blog')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        let(:invalid_attributes) { { title: nil }.to_json }
        before { post '/blogs', params: invalid_attributes, headers: headers }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(json['message'])
            .to match(/Validation failed. Title can't be blank./)
        end
      end
    end

    #Test suite for PUT /blogs/:id
    describe 'PUT /blogs/:id' do
      let(:valid_attributes) {{ title: 'My New Blog' }.to_json }

      context 'when the record exists' do
        before { put "/blogs/#{blog_id}", params: valid_attributes, headers: headers }

        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end

    #Test suite for DELETE /blogs/:id
    describe 'DELETE /blogs/:id' do
      before { delete "/blogs/#{blog_id}", params: {}, headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

end
