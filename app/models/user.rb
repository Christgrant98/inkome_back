class User < ApplicationRecord
  has_secure_password
  
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-ñ]+(\.[a-z\d\-ñ]+)*\.[a-z]+\z/i },
            presence: true,
            uniqueness: true

  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
