class Users::RetweetsController < RetweetsController
  before_action :set_user
  before_action :set_retweet, :authorize_retweet, only: %i[show destroy]

  def index
    @retweets = @user.retweets.page(params[:page])
  end

  def show
    @reply = @retweet.tweet.replies.build
  end

  def destroy
    @retweet.destroy!
    redirect_to user_retweets_url(@retweet.user), notice: 'リツイートを削除しました。'
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_retweet
      @retweet = @user.retweets.find(params[:id])
    end
end
