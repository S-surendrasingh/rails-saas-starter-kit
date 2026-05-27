require "swagger_helper"

RSpec.describe "API V1 Auth", type: :request do
  path "/api/v1/signup" do
    post "Signup user" do
      tags "Authentication"
      consumes "application/json"
      produces "application/json"

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name email password password_confirmation]
      }

      response "201", "Signup successful" do
        let(:user) do
          {
            name: "Surendra",
            email: "surendra@example.com",
            password: "password123",
            password_confirmation: "password123"
          }
        end

        run_test!
      end
    end
  end

  path "/api/v1/login" do
    post "Login user" do
      tags "Authentication"
      consumes "application/json"
      produces "application/json"

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response "200", "Login successful" do
        let!(:user) do
          User.create!(
            name: "Surendra",
            email: "surendra@example.com",
            password: "password123",
            password_confirmation: "password123"
          )
        end

        let(:credentials) do
          {
            email: "surendra@example.com",
            password: "password123"
          }
        end

        run_test!
      end
    end
  end
end