class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  def index
    ## Need to update this to get blog id from params
    @blogs = Blog.all
    json_response(@blogs)
  end

  def create
    @blog = current_user.blogs.create!(blog_params)
    json_response(@blog, :created)
  end

  def show
    json_response(@blog)
  end

  def update
    @blog.update(blog_params)
    head :no_content
  end

  def destroy
    @blog.destroy
    head :no_content
  end

  private

  def blog_params
    params.permit(:title)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
