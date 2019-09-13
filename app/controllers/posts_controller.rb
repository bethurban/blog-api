class PostsController < ApplicationController
  before_action :set_blog
  before_action :set_blog_post, only: [:show, :update, :destroy]
  # skip_before_action :authorize_request, only: :index, :show

  def index
    json_response(@blog.posts)
  end

  def show
    json_response(@post)
  end

  def create
    @blog.posts.create!(post_params)
    json_response(@blog, :created)
  end

  def update
    @post.update(post_params)
    head :no_content
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def set_blog_post
    @post = @blog.posts.find_by!(id: params[:id]) if @blog
  end
end
