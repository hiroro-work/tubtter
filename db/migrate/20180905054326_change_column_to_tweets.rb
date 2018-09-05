class ChangeColumnToTweets < ActiveRecord::Migration[5.2]
  def change
    change_column :tweets, :content, :text, null: false, default: nil
  end
end
