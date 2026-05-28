require 'swagger_helper'

RSpec.describe 'Profile API', type: :request do
  path '/api/v1/profile' do
    get 'Get current user profile' do
      tags 'Profile'
      produces 'application/json'

      security [ bearerAuth: [] ]

      response '200', 'Profile fetched successfully' do
        let!(:user) do
          User.create!(
            name: 'Surendra',
            email: 'surendra@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end

        let(:Authorization) do
          "Bearer #{JsonWebToken.encode(user_id: user.id)}"
        end

        run_test!
      end
    end
  end
end
