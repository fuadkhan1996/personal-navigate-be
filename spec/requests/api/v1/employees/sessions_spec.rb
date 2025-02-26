# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Employees::Sessions' do
  path '/api/v1/employees/session' do
    post 'Create an Employee Session' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ xApiKey: [] }]
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
        schema '$ref' => '#/components/schemas/SessionSuccess'
        run_test!
      end

      response '401', 'Authentication failed' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end

    get 'Get Current Logged In Employee' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      response '200', 'Logged In Employee Data' do
        schema '$ref' => '#/components/schemas/Dc::CompanyEmployeeBlueprintExtended'
        run_test!
      end

      response '401', 'Failed to Get User Data' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/employees/session/refresh' do
    post 'Refresh an Employee Session' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ xApiKey: [] }]

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
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/employees/session/update_password' do
    post 'Update Current Employee Password' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

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
        schema '$ref' => '#/components/schemas/SuccessMessage'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
