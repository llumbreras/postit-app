class PostsController < ApplicationController
  before_action :get_post, only: [:show,:edit,:update,:vote]
  before_action :require_user, except: [:index,:show]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new 
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user 
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

  def vote
    @vote = Vote.create(voteable: @post, author: current_user, vote: params[:vote])
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote has been added."
        else
          flash[:error] = "You're only allowed one vote per post."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:url,:title,:description,category_ids: [])
  end

  def get_post
    @post = Post.find_by(slug: params[:id])
  end


end
