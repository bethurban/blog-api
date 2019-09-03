require 'rails_helper'

RSpec.describe 'Posts API' do

  #Initialize the test data
  let!(:blog) { create(:blog) }
  let!(:posts) { create_list(:post, 20, blog_id: blog.id) }
  let(:blog_id) { blog.id }
  let(:id) { posts.first.id }

  #Test suite for GET /blogs/:blog_id/posts
  describe 'GET /blogs/:blog_id/posts' do
    before { get "/blogs/#{blog_id}/posts" }

    context 'when blog exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all blog posts' do
        expect(json.size).to eq(20)
      end
    end

    context 'when blog does not exist' do
      let(:blog_id) { 0 }

      it 'returns status code 404' do
        expect(response.body).to match(/Couldn't find Blog/)
      end
    end
  end

  #Test suite for GET /blogs/:blog_id/posts/:id
  describe 'GET /blogs/:blog_id/posts/:id' do
    before { get "/blogs/#{blog_id}/posts/#{id}" }

    context 'when blog post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the post' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when blog post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  #Test suite for POST /blogs/:blog_id/posts
  describe 'POST /blogs/:blog_id/posts' do
    let(:valid_attributes) { { title: 'A very interesting blog post', content: 'Super interesting!' } }

    context 'when request attributes are valid' do
      before { post "/blogs/#{blog_id}/posts", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/blogs/#{blog_id}/posts", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  #Test suite for PUT /blogs/:blog_id/posts/:id
  describe 'PUT /blogs/:blog_id/posts/:id' do
    let(:valid_attributes) { { title: 'A better blog post' } }

    before { put "/blogs/#{blog_id}/posts/#{id}", params: valid_attributes }

    context 'when post exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the post' do
        updated_post = Post.find(id)
        expect(updated_post.title).to match(/A better blog post/)
      end
    end

    context 'when the post does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not-found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  #Test suite for DELETE /blogs/:id
  describe 'DELETE /blogs/:id' do
    before { delete "/blogs/#{blog_id}/posts/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
