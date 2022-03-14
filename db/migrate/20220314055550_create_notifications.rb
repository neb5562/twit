class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.boolean :seen
      t.integer :type
      t.integer :user_id

      t.timestamps
    end
  end
end
