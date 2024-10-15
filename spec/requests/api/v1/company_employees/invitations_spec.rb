# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::CompanyEmployees::InvitationsController' do
  path '/api/v1/company_employees/invitation' do
    get 'Get Company Employee by Invitation Token' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :invitation_token, in: :query

      response '200', 'Company Employee Data' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 email: { type: :string },
                 invitation_sent_at: { type: :string },
                 invitation_accepted_at: { type: :string },
                 uuid: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 company: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     title: { type: :string },
                     logo: { type: :string },
                     guid: { type: :string },
                     company_type_name: { type: :string },
                     created_at: { type: :string },
                     updated_at: { type: :string }
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

    put 'Accept Invitation' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :invitation_token, in: :query
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          employee: {
            type: :object,
            properties: {
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w[password password_confirmation]
          }
        },
        required: %w[employee]
      }

      response '200', 'Company Employee Data' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 email: { type: :string },
                 invitation_sent_at: { type: :string },
                 invitation_accepted_at: { type: :string },
                 uuid: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
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

    post 'Invite New Employee' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'

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
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 email: { type: :string },
                 invitation_sent_at: { type: :string },
                 invitation_accepted_at: { type: :string },
                 uuid: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
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
                   }
                 }
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
               },
               required: %w[errors]

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
