class ApplicationController < ActionController::API
  private

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split.last if header

    decoded = JsonWebToken.decode(token)

    if decoded.present?
      @current_user = User.find_by(id: decoded[:user_id])
    end

    render json: { error: "Unauthorized access" }, status: :unauthorized unless @current_user
  end

  attr_reader :current_user
end