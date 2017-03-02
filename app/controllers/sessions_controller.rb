class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]
  before_action :require_logout, only: [:create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Welcome to Tracebook!"
      redirect_to current_user
    else
      flash[:error] = "We couldn't sign you in."
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    flash[:success] = "You have signed out."
    redirect_to root_url
  end
end
