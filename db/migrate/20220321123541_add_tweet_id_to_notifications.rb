class AddTweetIdToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :tweet_id, :integer, :null => true
  end
end
