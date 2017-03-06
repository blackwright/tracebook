class LikesController < ApplicationController

  def create
    @like = current_user.likes.build(like_params)
    @like.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: current_user) }
      format.js { render :likes }
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: current_user) }
      format.js { render :likes }
    end
  end

  private

    def like_params
      params.require(:like).permit(:likeable_type, :likeable_id)
    end
end
