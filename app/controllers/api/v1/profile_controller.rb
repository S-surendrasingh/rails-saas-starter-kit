class Api::V1::ProfileController < ApplicationController
  before_action :authorize_request

  def show
    render json: {
      user: {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email,
        role: current_user.role
      }
    }, status: :ok
  end
end