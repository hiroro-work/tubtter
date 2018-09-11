class RetweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i[new edit create update]
  before_action :set_tweet_retweet, only: %i[edit update]
  before_action :set_user, only: %i[index show destroy]
  before_action :set_user_retweet, only: %i[show destroy]
  before_action :authorize_retweet, only: %i[show edit update destroy]

  def index
    @retweets = @user.retweets.reverse_order.page(params[:page])
  end

  def show
    @reply = @retweet.tweet.replies.build
  end

  def new
    @retweet = @tweet.retweets.build
  end

  def edit
  end

  def create
    @retweet = @tweet.retweets.build(retweet_params)
    if @retweet.save
      redirect_to user_retweet_url(@retweet.user, @retweet), method: :get, notice: 'リツイートしました。'
    else
      redirect_to user_tweet_url(@tweet.user, @tweet), method: :get
    end
  end

  def update
    if @retweet.update(retweet_params)
      redirect_to user_retweet_url(@retweet.user, @retweet), method: :get, notice: 'リツイートを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @retweet.destroy
    redirect_to user_retweets_url(@retweet.user), notice: 'リツイートを削除しました。'
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def set_tweet_retweet
      @retweet = @tweet.retweets.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_user_retweet
      @retweet = @user.retweets.find(params[:id])
    end

    def authorize_retweet
      authorize @retweet
    end

    def retweet_params
      params.require(:retweet).permit(:content).merge(user: current_user)
    end
end
