class PostsController < ApplicationController

  def create
    @post = current_user.authored_posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
    else
      flash[:error] = "Couldn't create post"
    end
    redirect_back(fallback_location: current_user)
  end

  def destroy
    @post = current_user.authored_posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_back(fallback_location: current_user)
    else
      flash.now[:error] = "Couldn't delete post"
      render :index
    end
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:error] = "You're not authorized for that action"
        redirect_to root_url
      end
    end
end
