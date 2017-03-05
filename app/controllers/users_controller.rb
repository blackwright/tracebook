class UsersController < ApplicationController
  before_action :set_user, only: [:newsfeed]
  before_action :require_current_user, only: [:newsfeed]
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  before_action :disable_nav, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      User.send_welcome_email(@user.id)
      flash[:success] = "Welcome to Tracebook!"
      redirect_to user_profile_path(@user)
    else
      flash.now[:error] = "Couldn't create account."
      render :new
    end
  end

  def show
    @user = User.includes(:authored_posts =>
                          [{:likes => :liker},
                           {:comments => [:author, {:likes => :liker}]}])
                .find_by_id(params[:id])
    @posts = @user.authored_posts
    @new_post = Post.new if current_user == @user
  end

  def newsfeed
    @new_post = Post.new
    @posts = @user.feed_posts
  end

  def index
    @search_results = User.includes(:profile).search(params[:search])
  end

    private

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end

    def disable_nav
      @disable_nav = true
    end

    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:error] = "You're not authorized for that action."
        redirect_back(fallback_location: user_path(current_user))
      end
    end
end
