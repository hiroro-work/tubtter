class AddColumnToRetweet < ActiveRecord::Migration[5.2]
  def change
    add_column :retweets, :content, :text
  end
end
