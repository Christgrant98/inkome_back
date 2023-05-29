class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :fullname, :birthdate, :image,


  def image
    object.image.blob.url 
  end
end
