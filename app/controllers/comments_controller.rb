class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :require_current_user, only: [:destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment posted!"
    else
      flash[:error] = "Couldn't post comment."
    end
    redirect_back(fallback_location: current_user)
  end

  def destroy
    @comment = @commentable.comments.find_by_id(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted!"
    else
      flash[:error] = "Couldn't delete comment"
    end
    redirect_back(fallback_location: current_user)
  end

  private

    def require_current_user
      @comment = Comment.find_by_id(params[:id])
      unless current_user == @comment.author
        flash[:error] = "You're not authorized for that action"
        redirect_back(fallback_location: current_user)
      end
    end

    def set_commentable
      @commentable = extract_commentable
      redirect_back(fallback_location: current_user) unless @commentable
    end

    def extract_commentable
      params[:commentable].classify.constantize.find_by_id(commentable_id)
    end
end
