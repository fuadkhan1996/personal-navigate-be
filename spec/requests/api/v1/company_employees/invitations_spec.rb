# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::CompanyEmployees::InvitationsController' do
  path '/api/v1/company_employees/invitation' do
    get 'Get Company Employee by Invitation Token' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ xApiKey: [] }]

      parameter name: :invitation_token, in: :query, type: :string, required: true

      response '200', 'Company Employee Data' do
        schema '$ref' => '#/components/schemas/DcCompanyEmployeeBlueprintExtended'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end

    put 'Accept Invitation' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ xApiKey: [] }]

      parameter name: :invitation_token, in: :query, type: :string, required: true
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w[password password_confirmation]
          }
        },
        required: %w[employee]
      }

      response '200', 'Company Employee Data' do
        schema '$ref' => '#/components/schemas/DcCompanyEmployeeBlueprintExtended'
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

    post 'Invite New Employee' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_id, in: :query, type: :string
      parameter name: :company_employee, in: :body, schema: {
        type: :object,
        properties: {
          company_employee: {
            type: :object,
            properties: {
              employee_type: { type: :string },
              employee_attributes: {
                type: :object,
                properties: {
                  first_name: { type: :string },
                  last_name: { type: :string },
                  email: { type: :string }
                }
              }
            }
          }
        }
      }

      response '200', 'Company Employee Data' do
        schema '$ref' => '#/components/schemas/DcCompanyEmployeeBlueprintExtended'
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

  path '/api/v1/company_employees/invitations/{id}/resend_invite' do
    post 'Resend Invite to Employee' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :id, in: :path, type: :string

      response '200', 'Company Employee Data' do
        schema '$ref' => '#/components/schemas/DcCompanyEmployeeBlueprintExtended'
        run_test!
      end

      response '422', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/company_employees/invitations/bulk_invite' do
    post 'Bulk invite employees' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_id, in: :query, type: :string
      parameter name: :invitation, in: :body, schema: {
        type: :object,
        properties: {
          employee_type: { type: :string },
          email_addresses: { type: :array, items: { type: :string } }
        }
      }

      response '200', 'Invitations Sent Successfully.' do
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
