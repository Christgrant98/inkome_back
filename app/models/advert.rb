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

  validates :description, :name, :age, :phone, presence: true
  has_many_attached :images
end