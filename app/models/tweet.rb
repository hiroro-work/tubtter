class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :parent_tweet, class_name: 'Tweet', required: false
  has_many :replies, class_name: 'Tweet', foreign_key: 'parent_tweet_id', dependent: :nullify
  has_many :retweets, dependent: :destroy

  validates :content, presence: true
end
