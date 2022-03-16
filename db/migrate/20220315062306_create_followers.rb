class CreateFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :followers do |t|
      t.integer :follow
      t.integer :user_id

      t.timestamps
    end
  end
end
