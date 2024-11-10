class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    if user.persisted?
      # Generate JWT token for the user
      token = generate_token(user)
      render json: { status: 200, success: true, message: 'SignIn successfully.', token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    payload = { timestamp: Time.now, email: user&.email }
    secret_key = "783f123ceafa000785108cda09c53ef54d01a552006d094445ce3d7eaa5aa2218f49064f998b24c25e6d3b691c22481923ed63e6da7295e3893166fc84916f68"
    JWT.encode(payload, secret_key, "HS256")
  end
end
