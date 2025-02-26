# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Employees::ProfilesController' do
  path '/api/v1/employees/profile/update_email' do
    patch 'Update employee email' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              email: { type: :string }
            }
          }
        }
      }

      response '200', 'Email Updated Successfully.' do
        schema '$ref' => '#/components/schemas/Dc::CompanyEmployeeBlueprintExtended'
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema '$ref' => '#/components/schemas/Error422'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/employees/profile/verify_email_update' do
    post 'Update employee email update' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              confirmation_code: { type: :string }
            }
          }
        }
      }

      response '200', 'Email Verified Successfully.' do
        schema '$ref' => '#/components/schemas/SuccessMessage'
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/employees/profile' do
    put 'Update employee information' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              first_name: { type: :string },
              last_name: { type: :string }
            }
          }
        }
      }

      response '200', 'Employee updated Successfully.' do
        schema '$ref' => '#/components/schemas/SuccessMessage'
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema '$ref' => '#/components/schemas/Error422'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
