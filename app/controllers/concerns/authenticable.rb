module Authenticable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
  end

  private

  def authorize_request
    token = bearer_token
    decoded_token = JsonWebToken.decode(token)

    @current_user = User.find_by(id: decoded_token[:user_id]) if decoded_token.present?

    render json: { error: "Unauthorized access" }, status: :unauthorized unless @current_user
  end

  def bearer_token
    header = request.headers["Authorization"]
    header&.split&.last
  end
end