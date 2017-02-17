class PhotosController < ApplicationController
  before_action :set_user
  before_action :require_current_user, except: [:show, :index]

  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo uploaded!"
      redirect_to user_photo_path(@user, @photo)
    else
      flash.now[:error] = "Couldn't upload photo"
      render :new
    end
  end

  def show
    @photo = Photo.find_by_id(params[:id])
  end

  private

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def photo_params
      params.require(:photo).permit(:image, :url)
    end

    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:error] = "You're not authorized for that action"
        redirect_back(fallback_location: current_user)
      end
    end
end
