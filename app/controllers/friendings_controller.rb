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
end
