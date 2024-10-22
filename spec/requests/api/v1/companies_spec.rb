# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::CompaniesController' do
  path '/api/v1/companies' do
    get 'Get Linked Companies' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :company_type, in: :query, type: :string, description: 'Account/Carrier/Wholesaler/SubAgency'
      response '200', 'Companies List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string },
                   title: { type: :string },
                   guid: { type: :string },
                   logo: { type: :string },
                   company_type_name: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   primary_company_employee: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       uuid: { type: :string },
                       email: { type: :string },
                       first_name: { type: :string },
                       last_name: { type: :string },
                       invitation_sent_at: { type: :string },
                       invitation_accepted_at: { type: :string },
                       employee_type: { type: :string }
                     }
                   }
                 }
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

    post 'Create Company' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

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
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 guid: { type: :string },
                 logo: { type: :string },
                 company_type_name: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               }

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: {
                     type: :array,
                     items: {
                       type: :string
                     }
                   }
                 }
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
