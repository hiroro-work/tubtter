class RetweetsController < ApplicationController
  before_action :authenticate_user!

  private

    def authorize_retweet
      authorize @retweet
    end

    def retweet_params
      params.require(:retweet).permit(:content).merge(user: current_user)
    end
end
