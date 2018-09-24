class Tweets::RetweetsController < RetweetsController
  before_action :set_tweet
  before_action :set_retweet, :authorize_retweet, only: %i[edit update]

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
      render :new
    end
  end

  def update
    if @retweet.update(retweet_params)
      redirect_to user_retweet_url(@retweet.user, @retweet), method: :get, notice: 'リツイートを更新しました。'
    else
      render :edit
    end
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def set_retweet
      @retweet = @tweet.retweets.find(params[:id])
    end
end
