class FriendingsController < ApplicationController

  def create
    if new_friend = User.find_by_id(params[:id])
      current_user.friended_users << new_friend
      flash[:success] = "You're now friends with #{new_friend.full_name}"
      redirect_back(fallback_location: user_path(new_friend))
    else
      flash[:error] = "User not found"
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def destroy
    if ex_friend = User.find_by_id(params[:id])
      current_user.destroy_friendship(ex_friend)

      flash[:success] = "You've unfriended #{ex_friend.full_name}"
      redirect_back(fallback_location: user_path(current_user))
    else
      flash[:error] = "User not found"
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def index
    if @user = User.find_by_id(params[:user_id])
      @friends = @user.all_friends
    else
      flash[:error] = "User not found"
      redirect_back(fallback_location: user_path(current_user))
    end
  end
end
