class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :fullname, :age, :birthdate, :image,


  def image
    object.image.blob.url 
  end
  
end
