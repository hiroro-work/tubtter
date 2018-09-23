class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i[new edit create update]
  before_action :set_tweet_reply, only: %i[edit update]
  before_action :set_user, only: %i[index show destroy]
  before_action :set_user_reply, only: %i[show destroy]
  before_action :authorize_reply, only: %i[show edit update destroy]

  def index
    @replies = @user.replies.reverse_order.page(params[:page])
  end

  def show
  end

  def new
    @reply = @tweet.replies.build
  end

  def edit
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    if @reply.save
      redirect_to user_reply_url(@reply.user, @reply), method: :get, notice: 'リプライしました。'
    else
      redirect_to user_tweet_url(@tweet.user, @tweet), method: :get
    end
  end

  def update
    if @reply.update(reply_params)
      redirect_to user_reply_url(@reply.user, @reply), method: :get, notice: 'リプライを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @reply.destroy
    redirect_to user_replies_url(@reply.user), notice: 'リプライを削除しました。'
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def set_tweet_reply
      @reply = @tweet.replies.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_user_reply
      @reply = @user.replies.find(params[:id])
    end

    def authorize_reply
      authorize @reply
    end

    def reply_params
      params.require(:reply).permit(:content).merge(user: current_user)
    end
end
