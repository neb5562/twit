class AddRetweetTweetIdToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :retweet_tweet_id, :integer, :null => true
  end
end
