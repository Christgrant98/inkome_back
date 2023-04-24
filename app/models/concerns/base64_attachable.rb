module Base64Attachable
  extend ActiveSupport::Concern

  def add_images_from_base64(base64_images)
    base64_images&.each do |base64_image|
      add_image_from_base64(base64_image)
    end
  end

  def add_image_from_base64(base64_image)
    image = decode_base64_to_image(base64_image)
    content_type = extract_content_type_from_base64(base64_image)
    extension = extract_extension_from_base64(base64_image)
    filename = "image_#{Time.now.to_i}.#{extension}"
    images.attach(io: image, filename: filename, content_type: content_type)
  end

  def extract_content_type_from_base64(base64_image)
    base64_image.match(/data:(.*?);/)[1]
  end
  
  def extract_extension_from_base64(base64_image)
    content_type = extract_content_type_from_base64(base64_image)
    content_type.split('/').last
  end

  def decode_base64_to_image(base64_image)
    decoded_data = Base64.decode64(base64_image)
    StringIO.new(decoded_data)
  end

  def images_base64
    images.map do |image|
      base64_data = Base64.strict_encode64(image.download)
      {
        filename: image.filename.to_s,
        content_type: image.content_type,
        # base64: "data:#{image.content_type};base64,#{base64_data}",
        base64: base64_data,
      }
    end
  end
end