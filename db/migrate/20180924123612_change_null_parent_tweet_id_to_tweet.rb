class ChangeNullParentTweetIdToTweet < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tweets, :parent_tweet_id, true
  end
end
