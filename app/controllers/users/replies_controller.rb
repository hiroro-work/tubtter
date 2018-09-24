class Users::RepliesController < RepliesController
  before_action :set_user
  before_action :set_reply, :authorize_reply, only: %i[show destroy]

  def index
    @replies = @user.replies.reverse_order.page(params[:page])
  end

  def show
  end

  def destroy
    @reply.destroy!
    redirect_to user_replies_url(@reply.user), notice: 'リプライを削除しました。'
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_reply
      @reply = @user.replies.find(params[:id])
    end
end
