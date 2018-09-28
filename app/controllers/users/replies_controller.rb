class Users::RepliesController < RepliesController
  before_action :set_user

  def index
    @replies = @user.replies_only.page(params[:page])
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
