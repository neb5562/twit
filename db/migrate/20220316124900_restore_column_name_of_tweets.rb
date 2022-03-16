class RestoreColumnNameOfTweets < ActiveRecord::Migration[7.0]
  def change
    rename_column :tweets, :tweet_text, :tweet
  end
end
