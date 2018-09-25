class DropReply < ActiveRecord::Migration[5.2]
  def up
    drop_table :replies
  end
  
  def down
    create_table :replies do |t|
      t.references :user, foreign_key: true
      t.references :tweet, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
