class Follower < ApplicationRecord
    validates :user_id, uniqueness: { scope: :follow }
    belongs_to :user
end
