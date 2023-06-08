# == Schema Information
#
# Table name: adverts
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string
#  age         :integer
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Advert < ApplicationRecord
  include ActiveModel::Serialization

  has_many :advert_favorites
  validates :description, :name, :age, :phone, presence: true
  has_many_attached :images

  def is_fav(user)
    advert_favorites.where(user: user).any?
  end
end