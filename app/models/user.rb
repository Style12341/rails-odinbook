class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :follower_follows, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followee_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_follows, source: :follower
  has_many :followees, through: :followee_follows, source: :followee

  has_many :sender_follow_requests, foreign_key: :sender_id, class_name: 'FollowRequest', dependent: :destroy
  has_many :receiver_follow_requests, foreign_key: :receiver_id, class_name: 'FollowRequest', dependent: :destroy
  has_many :sent_requests, through: :sender_follow_requests, source: :receiver
  has_many :follow_requests, through: :receiver_follow_requests, source: :sender

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def feed
    Post.where(user: followees).or(Post.where(user: self)).order(created_at: :desc)
  end

  def likes?(likeable)
    likes.exists?(likeable:)
  end

  def accept_follow(user)
    request = receiver_follow_requests.find_by(sender: user)
    return unless request

    followees << user
    request.destroy
  end

  def reject_follow(user)
    request = receiver_follow_requests.find_by(sender: user)
    return unless request

    request.destroy
  end

  def send_follow(user)
    return if self == user
    return if followees.include?(user)

    sender_follow_requests.create(receiver: user)
  end

  def delete_follow(user)
    follow = follower_follows.find_by(follower: user) || followee_follows.find_by(followee: user)
    return unless follow

    is_follower = follow.follower == user
    follow.destroy
    return 'follower' if is_follower

    'followee'
  end

  def cancel_follow_request(user)
    request = sender_follow_requests.find_by(receiver: user)
    puts 'testtttttttt'
    puts request.inspect
    puts 'testtttttttt'
    return unless request

    request.destroy
  end
  def sent_request?(user)
    sent_requests.include?(user)
  end
  def following?(user)
    followees.include?(user)
  end
end
