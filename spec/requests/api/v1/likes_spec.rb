require 'rails_helper'

RSpec.describe "Api::V1::Likes", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
require 'swagger_helper'

RSpec.describe 'Likes API', type: :request do
  path '/api/v1/posts/{post_id}/like' do
    parameter name: :post_id, in: :path, type: :integer

    post 'Like a post' do
      tags 'Likes'

      security [ bearerAuth: [] ]

      produces 'application/json'

      response '201', 'Post liked successfully' do
        let!(:user) do
          User.create!(
            name: 'Surendra',
            email: 'likes@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end

        let!(:post_record) do
          Post.create!(
            title: 'Test Post',
            content: 'Test Content',
            status: 'published',
            user: user
          )
        end

        let(:post_id) { post_record.id }

        let(:Authorization) do
          "Bearer #{JsonWebToken.encode(user_id: user.id)}"
        end

        run_test!
      end
    end

    delete 'Unlike a post' do
      tags 'Likes'

      security [ bearerAuth: [] ]

      produces 'application/json'

      response '200', 'Post unliked successfully' do
        let!(:user) do
          User.create!(
            name: 'Surendra',
            email: 'unlikes@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end

        let!(:post_record) do
          Post.create!(
            title: 'Test Post',
            content: 'Test Content',
            status: 'published',
            user: user
          )
        end

        let!(:like) do
          Like.create!(
            user: user,
            post: post_record
          )
        end

        let(:post_id) { post_record.id }

        let(:Authorization) do
          "Bearer #{JsonWebToken.encode(user_id: user.id)}"
        end

        run_test!
      end
    end
  end
end
