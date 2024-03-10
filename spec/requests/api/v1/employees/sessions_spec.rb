require 'swagger_helper'

describe 'Api::V1::Employees::Sessions' do
  path '/api/v1/employees/sessions' do
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
        it 'returns a valid access token and refresh token' do
          schema type: :object,
                properties: {
                  access_token: { type: :string },
                  refresh_token: { type: :string }
                },
                required: %w[access_token refresh_token]

          let(:session) { { employee: { email: 'email', password: 'password' } } }
          run_test!
        end
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
  end
end
