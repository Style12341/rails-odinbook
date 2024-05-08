class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  validates_uniqueness_of :sender_id, scope: :receiver_id
  # Check if sender doesn't already follow receiver
  validate :sender_does_not_follow_receiver

  private

  def sender_does_not_follow_receiver
    return unless sender.followees.include?(receiver)

    errors.add(:sender, 'already follows receiver')
  end
end
