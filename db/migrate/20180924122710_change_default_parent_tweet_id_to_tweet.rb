class ChangeDefaultParentTweetIdToTweet < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tweets, :parent_tweet_id, nil
  end
end
