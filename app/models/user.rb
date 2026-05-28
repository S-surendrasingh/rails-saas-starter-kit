class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  
  enum :role, { user: 0, admin: 1 }, default: :user

  before_validation :normalize_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end
end
