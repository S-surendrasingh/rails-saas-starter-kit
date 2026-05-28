class ApplicationController < ActionController::API
    include Pagy::Backend
    include PaginationHelper
    include Authenticable
    include ApiResponse
end
