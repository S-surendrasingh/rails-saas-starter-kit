require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  path '/api/v1/posts/{post_id}/comments' do
    parameter name: :post_id, in: :path, type: :integer

    get 'List comments' do
      tags 'Comments'

      security [ bearerAuth: [] ]

      produces 'application/json'

      response '200', 'Comments fetched successfully' do
        let!(:user) do
          User.create!(
            name: 'Surendra',
            email: 'comments@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end

        let!(:post_record) do
          Post.create!(
            title: 'Post',
            content: 'Content',
            status: 'published',
            user: user
          )
        end

        let!(:comment) do
          Comment.create!(
            body: 'Nice post',
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

    post 'Create comment' do
      tags 'Comments'

      security [ bearerAuth: [] ]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: [ 'body' ]
      }

      response '201', 'Comment created successfully' do
        let!(:user) do
          User.create!(
            name: 'Surendra',
            email: 'createcomment@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end

        let!(:post_record) do
          Post.create!(
            title: 'Post',
            content: 'Content',
            status: 'published',
            user: user
          )
        end

        let(:post_id) { post_record.id }

        let(:Authorization) do
          "Bearer #{JsonWebToken.encode(user_id: user.id)}"
        end

        let(:comment) do
          {
            body: 'Amazing post'
          }
        end

        run_test!
      end
    end
  end
end
