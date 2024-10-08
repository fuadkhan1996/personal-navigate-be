# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Employees::ProfilesController' do
  path '/api/v1/employees/profile/update_email' do
    patch 'Update employee email' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
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
        schema type: :object,
               properties: {
                 id: { type: :string },
                 uuid: { type: :string },
                 email: { type: :string },
                 first_name: { type: :string },
                 last_name: { type: :string },
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

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end

  path '/api/v1/employees/profile/verify_email_update' do
    post 'Update employee email update' do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
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
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        run_test!
      end

      response '422', 'Unprocessable Entity' do
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
