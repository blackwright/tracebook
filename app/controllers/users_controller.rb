class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook!"
      redirect_to user_profile_path(@user)
    else
      flash.now[:error] = "Couldn't create user."
      render :new
    end
  end

    private

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
