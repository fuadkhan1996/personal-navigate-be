# frozen_string_literal: true

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
              password: { type: :string },
              entity_type: { type: :string }
            },
            required: %w[email password entity_type]
          }
        },
        required: %w[employee]
      }

      response '201', 'Authentication successful' do
        schema type: :object,
               properties: {
                 id: { type: :string },
                 uuid: { type: :string },
                 email: { type: :string },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 invitation_sent_at: { type: :string },
                 invitation_accepted_at: { type: :string },
                 access_token: { type: :string },
                 refresh_token: { type: :string },
                 token_expires_in: { type: :integer },
                 company: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     title: { type: :string },
                     guid: { type: :string },
                     logo: { type: :string },
                     company_type_name: { type: :string },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   },
                   required: %w[id title logo company_type_name created_at updated_at]
                 }
               },
               required: %w[id first_name last_name email access_token refresh_token token_expires_in company]

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

    get 'Get Current Logged In Employee' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      response '200', 'Logged In Employee Data' do
        schema type: :object,
               properties: {
                 id: { type: :string },
                 uuid: { type: :string },
                 email: { type: :string },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 invitation_sent_at: { type: :string },
                 invitation_accepted_at: { type: :string },
                 employee_type: { type: :string },
                 company: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     title: { type: :string },
                     guid: { type: :string },
                     logo: { type: :string },
                     company_type_name: { type: :string },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   },
                   required: %w[id title logo company_type_name created_at updated_at]
                 }
               },
               required: %w[id uuid first_name last_name email access_token refresh_token token_expires_in company]

        let(:session) { { employee: { email: 'email', password: 'password' } } }
        run_test!
      end

      response '401', 'Failed to Get User Data' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end

  path '/api/v1/employees/session/refresh' do
    post 'Refresh an Employee Session' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :refresh_access_token, in: :body, schema: {
        type: :object,
        properties: {
          refresh_token: { type: :string },
          email: { type: :string }
        },
        required: %w[refresh_token]
      }

      response '201', 'Authentication successful' do
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

        run_test!
      end

      response '401', 'Unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end

  path '/api/v1/employees/session/update_password' do
    post 'Update Current Employee Password' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              current_password: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            }
          }
        }
      }

      response '200', 'Authentication successful' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        run_test!
      end

      response '401', 'Unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end
end
