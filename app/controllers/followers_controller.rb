class FollowersController < ApplicationController
  before_action :authenticate_user!, :set_user
  before_action :set_relationship, only: %i[destroy]

  def index
    @users = @user.followers.page(params[:page])
  end

  def create
    @relationship = @user.passive_relationships.build(follower: current_user)
    if @relationship.save
      redirect_to user_url(@user), method: :get, notice: "#{@user.name} をフォローしました。"
    else
      redirect_to user_url(@user), method: :get
    end
  end

  def destroy
    @relationship.destroy!
    redirect_to user_url(@user), method: :get, notice: "#{@user.name} のフォローを解除しました。"
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_relationship
      @relationship = @user.passive_relationships.find(params[:id])
    end
end
