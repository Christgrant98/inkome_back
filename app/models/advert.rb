class Advert < ApplicationRecord
  include ActiveModel::Serialization

  has_many :advert_favorites
  has_many_attached :images

  
  # has_many :ad_tags

  validates :description, :name, :age, :phone, presence: true

  def is_fav(user)
    advert_favorites.where(user: user).any?
  end
end
