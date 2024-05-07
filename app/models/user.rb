class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :follower_follows, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followee_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_follows, source: :follower
  has_many :followees, through: :followee_follows, source: :followee

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def feed
    Post.where(user: followees).or(Post.where(user: self)).order(created_at: :desc)
  end

  def likes?(likeable) # Determine if this user likes a post
    Like.find_by(user: self, likeable:)
  end

  def following?(user) # Determine if this user follows another user
    Follow.find_by(follower: self, followee: user)
  end

  def following # Get all the users that this user follows including the ones that have not accepted the follow request
    followees.order(name: :asc)
  end

  def accepted_follows # Get all the users that follow this user and have accepted the follow request
    followers.where('follows.accepted = ?', true).order(name: :asc)
  end

  def pending_follows # Get all the users that this user follows but have not accepted the follow request
    followers.where('follows.accepted = ?', false).order(name: :asc)
  end
end
