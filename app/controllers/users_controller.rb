class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user, only: [:show, :followings, :followers, :allusers, :follow, :unfollow]

  def show
    @tweet = current_user.tweets.build
  end

  def followings
    @users = @user.all_following
  end

  def followers
    @users = @user.followers
  end

  def allusers
    @users = User.all.page(params[:page])
  end

  def follow
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user, notice: "You followed #{@user.name}." }
    end
  end

  def unfollow
    current_user.stop_following(@user)
    respond_to do |format|
      format.html { redirect_to @user, notice: "You unfollowed #{@user.name}." }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
