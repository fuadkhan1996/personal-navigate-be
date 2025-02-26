# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::CompanyEmployeesController' do
  path '/api/v1/company_employees/{id}' do
    put 'Update Company Employee' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ xApiKey: [] }]

      parameter name: :company_id, in: :query, type: :string, description: 'Account ID'
      parameter name: :id, in: :path, type: :string
      parameter name: :company_employee, in: :body, schema: {
        type: :object,
        properties: {
          company_employee: {
            type: :object,
            properties: {
              employee_attributes: {
                type: :object,
                properties: {
                  first_name: { type: :string },
                  last_name: { type: :string }
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

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/company_employees' do
    get 'List of Company Employees' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :company_id, in: :query, type: :string, description: 'Account ID'
      parameter name: :employee_type, in: :query, type: :string, description: 'Admin/Owner, Agent, Insured, SME'

      response '200', 'Company Employee Data' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/DcCompanyEmployeeBlueprint' }

        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
