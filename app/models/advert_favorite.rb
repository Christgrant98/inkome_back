class AdvertFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :advert

  validates :user_id, uniqueness: { scope: :advert_id, message: "user has already favorited this advert" }
end