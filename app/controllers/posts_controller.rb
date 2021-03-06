class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]

  def index
    @posts = Post.all.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def edit
    
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  private
  def post_params
    params.require(:post).permit(:item, :image, :place, :limitation).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
