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
class AdvertSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :age, :phone, :images

  def images
    object.images.map do |image|
      image.blob.url
    end
  end
end

# método de image - flutter se encarga de codificar y decodificar la imagen, entonces no hay procesamiento en rails 

# siempre recordar agregar los campos nuevos en Serializer respectivos.