class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :nullify

  validates :content, presence: true
end
