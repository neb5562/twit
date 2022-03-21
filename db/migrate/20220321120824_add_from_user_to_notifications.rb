class AddFromUserToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :from, :integer
  end
end
