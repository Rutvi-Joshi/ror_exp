require 'jwt'

class JWTService
  def self.encode(payload)
    # Set the expiration time to the current time + expiration_time (configured earlier)
    expiration_time = Time.now.to_i + JWTConfig.expiration_time

    # Create the payload with user data and expiration time
    payload = payload.merge(exp: expiration_time)

    # Encode the JWT with the secret key and algorithm from the config
    JWT.encode(payload, JWTConfig.secret, JWTConfig.algorithm)
  end

  def self.decode(token)
    # Decode the JWT with the secret key and algorithm from the config
    decoded_token = JWT.decode(token, JWTConfig.secret, true, { algorithm: JWTConfig.algorithm })

    # Return the payload (the decoded data)
    decoded_token.first
  rescue JWT::DecodeError
    nil  # Return nil if the token is invalid
  end
end
