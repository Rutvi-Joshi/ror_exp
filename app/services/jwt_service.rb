class JWTService
    HMAC_SECRET = "783f123ceafa000785108cda09c53ef54d01a552006d094445ce3d7eaa5aa2218f49064f998b24c25e6d3b691c22481923ed63e6da7295e3893166fc84916f68"
  
    # Encode a payload and generate a JWT token
    def self.encode(payload)
      JWT.encode(payload, HMAC_SECRET)
    end
  
    # Decode the JWT token and return the payload
    def self.decode(token)
      decoded = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::DecodeError => e
      nil
    end
  end