class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private

    def sign_in(user)
      user.regenerate_auth_token
      cookies[:auth_token] = user.auth_token
      @current_user = user
    end

    def permanent_sign_in(user)
      user.regenerate_auth_token
      cookies.permanent[:auth_token] = user.auth_token
      @current_user = user
    end

    def sign_out
      @current_user = nil
      cookies.delete(:auth_token)
    end

    def require_login
      unless signed_in_user?
        flash[:error] = "Please sign in to continue"
        redirect_to root_url
      end
    end

    def current_user
      if cookies[:auth_token]
        @current_user ||= User.find_by_auth_token(cookies[:auth_token])
      end
    end
    helper_method :current_user

    def signed_in_user?
      !!current_user
    end
    helper_method :signed_in_user?
end
