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
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 guid: { type: :string },
                 logo: { type: :string },
                 company_type_name: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 deleted_at: { type: :string },
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
                 },
                 assigned_company_employees: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       created_at: { type: :string },
                       updated_at: { type: :string },
                       company_employee: {
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

  path '/api/v1/companies/{company_id}/assigned_company_employees/{id}' do
    delete 'Remove Assigned Company Employee' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Assigned Company Employee Removed Successfully' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 guid: { type: :string },
                 logo: { type: :string },
                 company_type_name: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 deleted_at: { type: :string },
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
                 },
                 assigned_company_employees: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       created_at: { type: :string },
                       updated_at: { type: :string },
                       company_employee: {
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
                 }
               }

        run_test!
      end

      response '422', 'Unauthorized' do
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
