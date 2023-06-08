class ApplicationController < ActionController::API
  include ActiveStorage::SetCurrent
  before_action :authorize_request
  # Este método se utiliza como un filtro de autorización 
  #antes de que se ejecute cualquier acción en el controlador que lo incluya.
  # Verifica si hay una cabecera de autorización en la solicitud, 
  # si la hay, decodifica el token JWT y encuentra el usuario correspondiente.
  def authorize_request
    begin
      set_current_user
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
  
  def set_current_user
    header = get_auth_header
    return if header.blank?
    @decoded = ::JsonWebToken.decode(header)
    @current_user = User.find(@decoded[:user_id])
  end

  def get_auth_header
    header = request.headers['Authorization']
    header.split(' ').last if header
  end

  def serialize_with(serializer, record, options={})
    ActiveModelSerializers::SerializableResource.new(
      record, options.merge({ serializer: serializer })
    ).as_json
  end
end
