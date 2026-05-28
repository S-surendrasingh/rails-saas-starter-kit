require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  path '/api/v1/posts' do
    get 'Fetch posts' do
      tags 'Posts'

      security [ bearerAuth: [] ]

      produces 'application/json'

      parameter name: :page, in: :query, type: :integer
      parameter name: :status, in: :query, type: :string
      parameter name: :search, in: :query, type: :string

      response '200', 'Posts fetched successfully' do
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

    post 'Create post' do
      tags 'Posts'

      security [ bearerAuth: [] ]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string },
          status: { type: :string }
        },
        required: %w[title content]
      }

      response '201', 'Post created successfully' do
        let!(:user) do
          User.create!(
            name: 'Surendra',
            email: 'surendra2@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end

        let(:Authorization) do
          "Bearer #{JsonWebToken.encode(user_id: user.id)}"
        end

        let(:post) do
          {
            title: 'My First Post',
            content: 'This is my first post',
            status: 'published'
          }
        end

        run_test!
      end
    end
  end
end