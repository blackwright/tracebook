class ProfilesController < ApplicationController
  before_action :set_user
  before_action :require_current_user, except: [:show]
  before_action :require_owned_photo, only: [:set_profile, :set_cover]

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_profile_path(@user)
    else
      flash[:error] = "Couldn't update profile"
      render :edit
    end
  end

  def show
    @profile = current_user.profile
  end

  def set_avatar
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Profile picture updated!"
    else
      flash[:error] = "Couldn't update profile picture. #{@profile.errors.full_messages}"
    end
    redirect_back(fallback_location: current_user)
  end

  def set_cover
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Cover photo updated!"
    else
      flash[:error] = "Couldn't updated cover photo"
    end
    redirect_back(fallback_location: current_user)
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def profile_params
      params.require(:profile).permit(:birthday, :gender, :college, :hometown,
                                      :location, :phone, :tagline, :about,
                                      :avatar_id, :cover_id)
    end

    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:error] = "You're not authorized for that action"
        redirect_back(fallback_location: current_user)
      end
    end

    def require_owned_photo
      @photo = Photo.find_by_id(params[:photo_id])
      unless current_user.photos.include?(@photo)
        flash[:error] = "You're not authorized to use that photo"
        redirect_back(fallback_location: current_user)
      end
    end
end
