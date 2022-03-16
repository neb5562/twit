class EditDefaultTotweetsRetweetId < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tweets, :retweet_tweet_id, nil
  end
end
