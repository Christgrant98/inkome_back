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

  def add_images_from_base64(base64_images)#todo: meter estos 4 metodos en un concern llamado attachable
    base64_images&.each do |base64_image|
      add_image_from_base64(base64_image)
    end
  end
  
  def add_image_from_base64(base64_image)
    images.attach(io: decode_base64_image(base64_image), filename: "image.jpg")
  end

  def decode_base64_image(base64_image)
    file = Tempfile.new("image")
    file.binmode
    file.write(Base64.decode64(base64_image))
    file.rewind #todo: esto que hace?, asegurarse se que esto cierre el archivo y sino buscar como se hace
    file
  end

  def images_base64
    images.map do |image|
      {
        filename: image.filename.to_s,
        content_type: image.content_type,
        base64: Base64.encode64(image.download)
      }
    end
  end
end

# agregar la imagen en la validación
# si se va a utilizar activeStorage no se necesita usar base64 puesto que activeStorage nos va a guardar el archivo


# def image_base64
  #   return unless image.download
  #   image_data = Base64.encode64(image.download)
  #   file_type = image_data['data:.*;base64,'[/\/(.*?)\;/, 1]]
  #   "data:image/#{file_type};base64,#{image_data}"
  # end