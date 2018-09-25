class Tweets::RepliesController < RepliesController
  before_action :set_tweet

  def new
    @reply = @tweet.replies.build
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    if @reply.save
      redirect_to user_tweet_url(@reply.user, @reply), method: :get, notice: 'リプライしました。'
    else
      render template: 'tweets/show'
    end
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def reply_params
      params.require(:tweet).permit(:content).merge(user: current_user)
    end
end
