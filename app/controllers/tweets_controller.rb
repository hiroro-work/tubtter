class TweetsController < ApplicationController
  before_action :authenticate_user!, :set_user
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :require_my_tweet, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @tweet = current_user.tweets.build
  end

  def edit
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to current_user, notice: 'Tweet was successfully created.' }
      else
        format.html { redirect_to current_user }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to [current_user, @tweet], notice: 'Tweet was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Tweet was successfully destroyed.' }
    end
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_tweet
      @tweet = @user.tweets.find(params[:id])
    end

    def require_my_tweet
      unless @user == current_user
        redirect_to [@user, @tweet], alert: "It is not your tweet!"
      end
    end

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
