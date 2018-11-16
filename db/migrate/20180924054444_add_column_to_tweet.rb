class AddColumnToTweet < ActiveRecord::Migration[5.2]
  def change
    add_reference :tweets, :parent_tweet, foreign_key: { to_table: :tweets }
  end
end
