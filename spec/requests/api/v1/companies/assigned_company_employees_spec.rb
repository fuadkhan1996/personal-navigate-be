# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Companies::AssignedCompanyEmployeesController' do
  path '/api/v1/companies/{company_id}/assigned_company_employees' do
    post 'Assign Company Employee to a Company' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_id, in: :path, type: :string
      parameter name: :assigned_company_employee, in: :body, schema: {
        type: :object,
        properties: {
          assigned_company_employee: {
            type: :object,
            properties: {
              company_employee_id: { type: :string }
            }
          }
        }
      }

      response '201', 'Company Employee Assigned' do
        schema '$ref' => '#/components/schemas/DcCompanyBlueprintWithPrimaryCompanyEmployee'
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

  path '/api/v1/companies/{company_id}/assigned_company_employees/{id}' do
    delete 'Remove Assigned Company Employee' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Assigned Company Employee Removed Successfully' do
        schema '$ref' => '#/components/schemas/DcCompanyBlueprintWithPrimaryCompanyEmployee'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
