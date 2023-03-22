class Advert < ApplicationRecord
  validates :description, :name, :age, :phone, presence: true
end
