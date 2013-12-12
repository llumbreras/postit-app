class PostsController < ApplicationController
  before_action :get_post, only: [:show,:edit,:update]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = User.first
    if @post.save
      flash[:notice] = "Successfully created the post"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:url,:title,:description)
  end

  def get_post
    @post = Post.find(params[:id])
  end

end
