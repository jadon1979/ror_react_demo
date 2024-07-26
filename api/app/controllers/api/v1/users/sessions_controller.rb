# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.errors.empty?
      render json: {
        message: 'Logged in successfully.',
        token: { access_token: current_token },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: 200
    else
      render json: resource.errors, status: 400
    end
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def respond_to_on_destroy
    head :ok
  end
end
