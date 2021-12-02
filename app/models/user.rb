class User < ApplicationRecord
  has_secure_password
  has_many :reservations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def to_token_payload
    {
      sub: id,
      first_name: first_name,
      last_name: last_name,
      role: role,
      email: email
    }
  end
end
