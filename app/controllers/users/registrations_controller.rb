# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # POST /resource
  def create
    super do |resource|
      sign_in(resource)  # Sign the user in after registration

      # Render custom JSON response with selected user attributes
      return render json: { message: 'Signed up successfully.', user: resource.as_json(except: [:password, :password_digest]) }, status: :created
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
