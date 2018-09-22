class FollowersController < ApplicationController
  before_action :authenticate_user!, :set_user

  def index
    @users = @user.followers.page(params[:page])
  end

  def create
    if @user.follow(current_user)
      redirect_to user_url(@user), method: :get, notice: "#{@user.name} をフォローしました。"
    else
      redirect_to user_url(@user), method: :get
    end
  end

  def destroy
    @user.unfollow!(current_user)
    redirect_to user_url(@user), method: :get, notice: "#{@user.name} のフォローを解除しました。"
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
