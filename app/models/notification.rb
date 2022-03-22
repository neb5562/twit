class Notification < ApplicationRecord
    belongs_to :sender, :class_name => "User", :foreign_key => "from"
    has_one :rec, :class_name => "User", :foreign_key => "user_id"
end
