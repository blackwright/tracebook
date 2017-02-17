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
end
