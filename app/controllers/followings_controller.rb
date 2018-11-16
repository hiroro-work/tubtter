class FollowingsController < ApplicationController
  before_action :authenticate_user!, :set_user

  def index
    @users = @user.followings.page(params[:page])
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
