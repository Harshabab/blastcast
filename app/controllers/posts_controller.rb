class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!,       except: [ :index, :show]
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
@comments = Comment.where(post_id: @post)
@random_post = Post.where.not(id: @post).order("RANDOM()").first
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post =Post.find(params[:id])
  end

  def update
    @post =Post.find(params[:id])
    if @post.update(params[:post].permit(:title, :body, :image, :link))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end
  def upvote
    @post.upvote_by current_user
    redirect_to @post
  end
  def downvote
    @post.downvote_by current_user
    redirect_to @post
  end
  private

  def find_post
    @post= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :body, :image)
  end

end

