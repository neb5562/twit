class Tweet < ApplicationRecord
    belongs_to :user
    has_many :like
    validates :tweet, presence: true
end
