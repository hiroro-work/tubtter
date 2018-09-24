class TweetsController < ApplicationController
  before_action :authenticate_user!, :set_user
  before_action :set_tweet, only: %i[show edit update destroy]

  def show
    @reply = @tweet.replies.build
  end

  def new
    @tweet = current_user.tweets.build
  end

  def edit
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to current_user, notice: 'つぶやきました。'
    else
      render template: 'users/show'
    end
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to user_tweet_url(current_user, @tweet), notice: 'ツイートを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to current_user, notice: 'ツイートを削除しました。'
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_tweet
      @tweet = @user.tweets.find(params[:id])
      authorize @tweet
    end

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
