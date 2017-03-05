class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :require_current_user, only: [:destroy]
  before_action :require_friend, only: [:create]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment posted."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render :create_success }
      end
    else
      flash[:error] = "Couldn't post comment."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render partial: "shared/flash_ajax" }
      end
    end
  end

  def destroy
    @comment = @commentable.comments.find_by_id(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted."
    else
      flash[:error] = "Couldn't delete comment."
    end
    redirect_back(fallback_location: current_user)
  end

  private

    def comment_params
      params.require(:comment).permit(:commentable_type,
                                      :commentable_id,
                                      :body)
    end

    def commentable_id
      case params[:commentable]
      when "Post"
        params[:post_id]
      when "Photo"
        params[:photo_id]
      end
    end

    def set_commentable
      @commentable = extract_commentable
      redirect_back(fallback_location: current_user) unless @commentable
    end

    def extract_commentable
      params[:commentable].classify.constantize.find_by_id(commentable_id)
    end

    def require_current_user
      @comment = Comment.find_by_id(params[:id])
      unless current_user == @comment.author
        flash[:error] = "You're not authorized for that action."
        redirect_back(fallback_location: current_user)
      end
    end

    def require_friend
      unless current_user == @commentable.author ||
             current_user.all_friends.include?(@commentable.author)
        flash[:error] = "You must be friends to leave a comment."
        redirect_back(fallback_location: current_user)
      end
    end
end
