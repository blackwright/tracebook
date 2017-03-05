class PostsController < ApplicationController
  before_action :require_current_user

  def create
    @post = current_user.authored_posts.build(post_params)
    if @post.save
      flash[:success] = "Post has been created."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render :create_success }
      end
    else
      flash[:error] = "Couldn't create post."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render partial: "shared/flash_ajax" }
      end
    end
  end

  def destroy
    @post = current_user.authored_posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render :destroy_success }
      end
    else
      flash.now[:error] = "Couldn't delete post."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js { render partial: "shared/flash_ajax" }
      end
    end
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:error] = "You're not authorized for that action."
        redirect_to root_url
      end
    end
end
