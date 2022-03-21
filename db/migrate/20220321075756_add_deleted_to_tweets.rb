class AddDeletedToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :deleted, :boolean, :default => false
  end
end
