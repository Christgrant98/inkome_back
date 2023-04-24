module Base64Attachable
  extend ActiveSupport::Concern

  def add_images_from_base64(base64_images)
    base64_images&.each do |base64_image|
      add_image_from_base64(base64_image)
    end
  end

  def add_image_from_base64(base64_image)
    image = decode_base64_to_image(base64_image)
    images.attach(image)
  end

  def decode_base64_to_image(base64_image)
    content_type = MIME::Types.of(Base64.decode64(base64_image))[0].content_type
    ActiveStorage::Blob.create_after_upload!(
      io: StringIO.new(Base64.decode64(base64_image)),
      filename: "#{SecureRandom.hex}.#{content_type.preferred_extension}",
      content_type: content_type.to_s
    )
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