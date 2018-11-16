class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @tweet = current_user.tweets.build
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
