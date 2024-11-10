require 'dry/configurable'

module JWTConfig
  extend Dry::Configurable

  # Define settings with defaults
  setting :secret, default: '783f123ceafa000785108cda09c53ef54d01a552006d094445ce3d7eaa5aa2218f49064f998b24c25e6d3b691c22481923ed63e6da7295e3893166fc84916f68'
  setting :expiration_time, default: 86400
  setting :request_formats, default: { user: [:json] }
  setting :algorithm, default: 'HS256'
end