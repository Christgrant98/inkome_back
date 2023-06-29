class Advert < ApplicationRecord
  include ActiveModel::Serialization

  belongs_to :user
  has_many :advert_favorites
  has_many_attached :images

  validates :user_id, :description, :name, :age, :phone, presence: true

  def is_fav(user)
    advert_favorites.where(user: user).any?
  end
end
