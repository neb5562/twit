class Tweet < ApplicationRecord
    belongs_to :user
    has_many :like, dependent: :delete_all
    #belongs_to :tweet, foreign_key: :retweet_tweet_id, optional: true
    belongs_to :child, :class_name => "Tweet", :foreign_key => "retweet_tweet_id", optional: true
    has_many :retweet, :class_name => "Tweet", :foreign_key => "retweet_tweet_id", dependent: :delete_all
    validates :tweet, length: {minimum: 1, maximum: 280},  presence: true
    self.per_page = 10

    private
end
