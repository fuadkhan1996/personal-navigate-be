# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::CompaniesController' do
  path '/api/v1/companies' do
    get 'Get Linked Companies' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_type, in: :query, type: :string, description: 'Account/Carrier/Wholesaler/SubAgency'
      response '200', 'Companies List' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/DcCompanyBlueprintWithPrimaryCompanyEmployee' }

        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end

    post 'Create Company' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company, in: :body, schema: {
        type: :object,
        properties: {
          company: {
            type: :object,
            properties: {
              title: { type: :string },
              logo: { type: :string },
              phone_number: { type: :string },
              website: { type: :string },
              company_type_name: { type: :string },
              employee_attributes: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    first_name: { type: :string },
                    last_name: { type: :string },
                    email: { type: :string }
                  },
                  required: %w[first_name last_name email]
                }
              }
            },
            required: %w[title company_type_name employee_attributes]
          }
        },
        required: %w[company]
      }

      response '201', 'Company Created' do
        schema '$ref' => '#/components/schemas/DcCompanyBlueprint'
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

  path '/api/v1/companies/{id}' do
    get 'Get Linked Company' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :id, in: :path, type: :string
      response '200', 'Company Data' do
        schema '$ref' => '#/components/schemas/DcCompanyBlueprintWithPrimaryCompanyEmployee'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end

      response '404', 'Not Found' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
