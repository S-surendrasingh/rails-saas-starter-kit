module ApiResponse
  extend ActiveSupport::Concern

  private

  def success_response(message:, data: {}, status: :ok)
    render json: {
      success: true,
      message: message,
      data: data
    }, status: status
  end

  def error_response(message:, errors: [], status: :unprocessable_entity)
    render json: {
      success: false,
      message: message,
      errors: errors
    }, status: status
  end
end
