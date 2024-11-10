class ApplicationController < ActionController::Base
  before_action :set_current_user
  # before_action :authenticate_user, except: [:sign_in]
  allow_browser versions: :modern
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  SECREAT_KEY="783f123ceafa000785108cda09c53ef54d01a552006d094445ce3d7eaa5aa2218f49064f998b24c25e6d3b691c22481923ed63e6da7295e3893166fc84916f68"

  def set_current_user
    auth_header = request.headers['Authorization']
    if auth_header.present?
      token = auth_header.split(' ').last
      begin
        # Decode the token to retrieve the user ID
        data = JWT.decode(token, SECREAT_KEY) rescue nil
        user_email = data[0]["email"]
        # Find the user based on the ID from the token
        @current_user = User.find_by(email: user_email)
      rescue
        @current_user = nil
      end
    else
      @current_user = nil
    end
  end

  def current_user
    @current_user
  end

  def authenticate_user!
    unless current_user
      render json: { error: "You must be logged in to access this resource" }, status: :unauthorized
    end
  end
end
