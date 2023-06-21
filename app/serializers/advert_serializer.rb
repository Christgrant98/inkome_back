class AdvertSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :age, :phone, :images, :is_fav, :ad_tags

  def is_fav
    current_user = instance_options.dig(:serializer_options, :current_user)
    return false if current_user.blank?
    object.is_fav(current_user)
  end

  def images
    object.images.map do |image|
      image.blob.url
    end
  end
end
