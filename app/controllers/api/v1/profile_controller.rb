class Api::V1::ProfileController < ApplicationController
  before_action :authorize_request

  def show
    success_response(
      message: "Profile fetched successfully",
      data: {
        user: UserSerializer.new(current_user).as_json
      }
    )
  end
end
