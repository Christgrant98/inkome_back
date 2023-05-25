# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  phone           :string
#  fullname        :string
#  age             :integer
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-ñ]+(\.[a-z\d\-ñ]+)*\.[a-z]+\z/i },
            presence: true,
            uniqueness: true

  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
