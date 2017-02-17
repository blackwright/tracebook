class ProfilesController < ApplicationController
  before_action :set_user
  before_action :require_current_user, except: [:show]

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
end
