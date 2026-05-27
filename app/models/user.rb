class User < ApplicationRecord
    has_secure_password

    enum :role, { user: 0, admin: 1 }, default: :user

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
