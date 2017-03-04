class FriendingsController < ApplicationController
  before_action :require_login

  def create
    friending = current_user.initiated_friendings
                            .build(:friender_id => current_user.id,
                                   :friended_id => params[:id])
    if friending.save
      flash[:success] = "Friend request sent."
      redirect_back(fallback_location: current_user)
    else
      flash[:error] = "Couldn't send friend request."
      redirect_back(fallback_location: current_user)
    end
  end

  def update
    friending = Friending.find_by_id(params[:id])
    friending.update(:accepted => true)
    if friending.save
      flash[:success] = "Friend request accepted."
      redirect_back(fallback_location: current_user)
    else
      flash[:error] = "Couldn't confirm friend request."
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy
    if ex_friend = User.find_by_id(params[:id])
      current_user.destroy_friendship(ex_friend)
      flash[:success] = "Friend has been removed."
      redirect_back(fallback_location: current_user)
    else
      flash[:error] = "User not found."
      redirect_back(fallback_location: current_user)
    end
  end

  def index
    if @user = User.find_by_id(params[:user_id])
      @friends = @user.all_friends
    else
      flash[:error] = "User not found."
      redirect_back(fallback_location: user_path(current_user))
    end
  end
end
