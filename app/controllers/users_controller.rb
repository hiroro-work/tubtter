class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user, only: %i[show followings followers allusers follow unfollow]

  def show
    @tweet = current_user.tweets.build
  end

  def followings
    @users = Kaminari.paginate_array(@user.all_following).page(params[:page])
  end

  def followers
    @users = Kaminari.paginate_array(@user.followers).page(params[:page])
  end

  def allusers
    @users = User.all.page(params[:page])
  end

  def follow
    current_user.follow(@user)
    redirect_to @user, notice: "#{@user.name} をフォローしました。"
  end

  def unfollow
    current_user.stop_following(@user)
    redirect_to @user, notice: "#{@user.name} のフォローを解除しました。"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
