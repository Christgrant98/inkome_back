class User < ApplicationRecord
  has_many :adverts, through: :advert_favorites
  has_many :advert_favorites
  
  before_validation :downcase_email

  has_secure_password
  has_one_attached :image
  
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-ñ]+(\.[a-z\d\-ñ]+)*\.[a-z]+\z/i },
            presence: true,
            uniqueness: true

  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
