class Tweets::TweetsController < TweetsController
  before_action :set_tweet
  before_action :set_reply, :authorize_reply, only: %i[edit update]

  def new
    @reply = @tweet.replies.build
  end

  def edit
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    if @reply.save
      redirect_to user_tweet_url(@reply.user, @reply), method: :get, notice: 'リプライしました。'
    else
      render template: 'tweets/show'
    end
  end

  def update
    if @reply.update(reply_params)
      redirect_to user_reply_url(@reply.user, @reply), method: :get, notice: 'リプライを更新しました。'
    else
      render :edit
    end
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def set_reply
      @reply = @tweet.replies.find(params[:id])
    end

    def authorize_reply
      authorize @reply
    end

    def reply_params
      params.require(:tweet).permit(:content).merge(user: current_user)
    end
end
