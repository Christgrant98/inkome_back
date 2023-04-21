module Base64Attachable
  extend ActiveSupport::Concern

  def add_images_from_base64(base64_images)
    base64_images&.each do |base64_image|
      add_image_from_base64(base64_image)
    end
  end
  
  def add_image_from_base64(base64_image)
    decode_base64_image(base64_image) do |file|
      images.attach(io: file, filename: "image.jpg")
    end
  end

  def decode_base64_image(base64_image)
    file = Tempfile.new("image")
    file.binmode
    file.write(Base64.decode64(base64_image))
    file.rewind
    yield(file)
  ensure
    file.close
    file.unlink
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