class Api::V1::AuthController < ApplicationController
  def signup
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user_id: user.id)

      success_response(
        message: "Signup successful",
        data: {
          token: token,
          user: UserSerializer.new(user).as_json
        },
        status: :created
      )
    else
      error_response(
        message: "Signup failed",
        errors: user.errors.full_messages
      )
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      success_response(
        message: "Login successful",
        data: {
          token: token,
          user: UserSerializer.new(user).as_json
        }
      )
    else
      error_response(
        message: "Invalid email or password",
        status: :unauthorized
      )
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end