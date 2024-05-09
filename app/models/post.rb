class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
