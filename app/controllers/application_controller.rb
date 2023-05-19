class ApplicationController < ActionController::API
  include ActiveStorage::SetCurrent
  before_action :authorize_request
  # Este método se utiliza como un filtro de autorización 
  #antes de que se ejecute cualquier acción en el controlador que lo incluya.
  # Verifica si hay una cabecera de autorización en la solicitud, 
  # si la hay, decodifica el token JWT y encuentra el usuario correspondiente.
  def authorize_request
    # Se obtiene la cabecera de autorización de la solicitud
    header = request.headers['Authorization']
    # Si existe una cabecera de autorización, se separa el token JWT del tipo de esquema (Bearer) 
    # y se toma sólo el token
    header = header.split(' ').last if header
    begin
      # Se decodifica el token JWT y se obtiene el hash con los datos decodificados
      @decoded = ::JsonWebToken.decode(header)
      # Se encuentra el usuario correspondiente utilizando el ID del usuario en el hash decodificado
      @current_user = User.find(@decoded[:user_id])
    # Si no se encuentra el usuario, se renderiza un error 401 (no autorizado)
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    # Si hay un error al decodificar el token JWT, se renderiza un error 401 (no autorizado)
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
end
