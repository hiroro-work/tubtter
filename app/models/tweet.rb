class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :nullify
  has_many :retweets, dependent: :destroy

  validates :content, presence: true
end
