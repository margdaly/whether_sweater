class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  has_secure_password

  before_create do
    self.api_key = SecureRandom.hex(10)
  end
end
