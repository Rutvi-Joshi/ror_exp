# config/initializers/rswag-api.rb
Rswag::Api.configure do |config|
  # config.swagger_root = Rails.root.to_s + '/swagger/'
  config.openapi_root = Rails.root.to_s + '/swagger'
end
