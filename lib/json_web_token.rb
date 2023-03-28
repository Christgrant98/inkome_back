

class JsonWebToken
    #  Se define la clave secreta como una constante 
    #  utilizando la clave secreta base de la aplicación Rails
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  
    # Este método se utiliza para codificar un token JWT. 
    # Toma un hash como argumento `payload` y una fecha y hora de expiración opcional `exp` 
    # (con un valor predeterminado de 24 horas desde el momento actual).

    def self.encode(payload, exp = 24.hours.from_now)
      # Se agrega la fecha de expiración al hash `payload` y se convierte a tiempo UNIX.
      payload[:exp] = exp.to_i
      # Se codifica el hash `payload` en un token JWT utilizando el algoritmo de codificación JWT 
      # y la clave secreta `SECRET_KEY`.
      JWT.encode(payload, SECRET_KEY)
    end
  
    # Este método se utiliza para decodificar un token JWT. Toma un token JWT como argumento `token`.
    def self.decode(token)
      # Se decodifica el token JWT utilizando la clave secreta `SECRET_KEY` 
      # y se obtiene un hash con los datos decodificados.
      decoded = JWT.decode(token, SECRET_KEY)[0]
      # Se convierte el hash decodificado en un objeto `HashWithIndifferentAccess`, 
      # que permite el acceso a los valores mediante símbolos o cadenas de caracteres indistintamente.
      HashWithIndifferentAccess.new decoded
    end
  end
  