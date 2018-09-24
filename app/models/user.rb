class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followee_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followee

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def tweets_only
    tweets.where(parent_tweet: nil)
  end

  def replies_only
    tweets.where.not(parent_tweet: nil)
  end

  def unfollowings
    User.where.not(id: followings.pluck(:id).push(id))
  end

  def follow(user)
    passive_relationships.create(follower: user)
  end

  def unfollow!(user)
    passive_relationships.find_by!(follower: user).destroy!
  end

  def following?(user)
    followings.include?(user)
  end
end
