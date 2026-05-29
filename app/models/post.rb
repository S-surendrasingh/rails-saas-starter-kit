class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  enum :status, { draft: 0, published: 1 }, default: :draft

  validates :title, presence: true
  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def likes_count
    likes.count
  end
end
