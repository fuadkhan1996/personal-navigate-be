require 'swagger_helper'

describe 'Api::V1::Employees::Sessions' do
  path '/api/v1/employees/session' do
    post 'Create an Employee Session' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          }
        },
        required: %w[employee]
      }

      response '200', 'Authentication successful' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     access_token: { type: :string },
                     refresh_token: { type: :string },
                     token_expires_in: { type: :integer }
                   },
                   required: %w[access_token refresh_token token_expires_in]
                 }
               },
               required: %w[data]

        let(:session) { { employee: { email: 'email', password: 'password' } } }
        run_test!
      end

      response '401', 'Authentication failed' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        let(:session) { { email: 'invalidemail@mydatacrest.com', password: 'password' } }
        run_test!
      end
    end

    get 'Get Current Logged In User' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'Logged In User Data' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     attributes: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         email: { type: :string },
                         first_name: { type: :string },
                         last_name: { type: :string },
                         cognito_username: { type: :string }
                       },
                       required: %w[id email first_name last_name cognito_username]
                     }
                   },
                   required: %w[data]
                 }
               }

        let(:session) { { access_token: 'access_token' } }
        run_test!
      end

      response '401', 'Failed to Get User Data' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        let(:session) { { access_token: 'access_token' } }
        run_test!
      end
    end
  end
end
