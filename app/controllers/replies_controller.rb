class RepliesController < ApplicationController
  before_action :authenticate_user!

  private

    def authorize_reply
      authorize @reply
    end

    def reply_params
      params.require(:reply).permit(:content).merge(user: current_user)
    end
end
