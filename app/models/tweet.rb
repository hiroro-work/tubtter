class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies

  validates :content, presence: true
end
