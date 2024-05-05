class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :follower_follows, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followee_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_follows, source: :followee
  has_many :followees, through: :followee_follows, source: :follower

  has_many :accepted_follows, -> { where(accepted: true) }, foreign_key: :followee_id, class_name: 'Follow'
  has_many :pending_follows, -> { where(accepted: false) }, foreign_key: :followee_id, class_name: 'Follow'
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def feed
    Post.where(user: followees).or(Post.where(user: self)).order(created_at: :desc)
  end
end
