class Tweet < ApplicationRecord
    belongs_to :user
    has_many :like
    #belongs_to :tweet, foreign_key: :retweet_tweet_id, optional: true
    belongs_to :child, :class_name => "Tweet", :foreign_key => "retweet_tweet_id", optional: true
    validates :tweet, length: {minimum: 1, maximum: 280},  presence: true
end
