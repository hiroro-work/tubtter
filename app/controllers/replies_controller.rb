class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[index show edit update destroy]
  before_action :set_reply, only: %i[show edit update destroy]
  before_action :set_tweet, only: %i[new create]

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
      redirect_to user_reply_url(current_user, @reply), method: :get, notice: 'リプライしました。'
    else
      redirect_to user_tweet_url(@user, @tweet)
    end
  end

  def update
    if @reply.update(reply_params)
      redirect_to user_reply_url(current_user, @reply), method: :get, notice: 'リプライを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @reply.destroy
    redirect_to user_replies_url(current_user), notice: 'リプライを削除しました。'
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_reply
      @reply = @user.replies.find(params[:id])
      authorize @reply
    end

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def reply_params
      params.require(:reply).permit(:content).merge(user: current_user)
    end
end
