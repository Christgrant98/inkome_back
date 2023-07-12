class StorySerializer < ActiveModel::Serializer
  attributes :id, :image, :created_at, :user_id

  def image
    object.image.blob.url
  end

  def user_id
    object.user_id
  end
end
