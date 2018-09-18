class CommentsController < ApplicationController
  before_action :correct_user, only: :destroy
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end
  private

  def comment_params
    params.require(:comment).permit(:name, :body)
  end
  def correct_user
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find_by(id: params[:id])
    if @comment.nil?
      flash[:alert] = "Not your comment!"
      #redirect_to post_path(@post)
      redirect_to post_path(@post)
      #redirect_to :back
    end
  end
end
