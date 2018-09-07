class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :replies, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: :false }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_followable
  acts_as_follower
end
