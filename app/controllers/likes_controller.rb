class LikesController < ApplicationController

  def create
    @like = current_user.likes.build(like_params)
    @like.save
    redirect_back(fallback_location: user_path(current_user))
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: user_path(current_user))
  end

  private

    def like_params
      params.require(:like).permit(:likeable_type, :likeable_id)
    end
end
