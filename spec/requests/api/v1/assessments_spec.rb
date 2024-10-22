# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Assessments' do
  path '/api/v1/assessments' do
    post 'Create Assessment' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :assessment, in: :body, schema: {
        type: :object,
        properties: {
          assessment: {
            type: :object,
            properties: {
              title: { type: :string },
              tis_order_id: { type: :string },
              form_data: { type: :object }
            },
            required: %w[title form_data]
          }
        },
        required: %w[assessment]
      }

      response '201', 'Assessment Created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 message: { type: :string }
               },
               required: %w[id message]

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

    get 'Get Assessments' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      response '200', 'Assessment List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   tis_order_id: { type: :string },
                   status: { type: :string },
                   completed_at: { type: :string },
                   form_data: { type: :object },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   account: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       uuid: { type: :string },
                       title: { type: :string },
                       guid: { type: :string },
                       logo: { type: :string },
                       deleted_at: { type: :string },
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

  path '/api/v1/assessments/{id}' do
    get 'Get Assessment' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :id, in: :path, type: :string
      response '200', 'Assessment Data' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 tis_order_id: { type: :string },
                 status: { type: :string },
                 completed_at: { type: :string },
                 form_data: { type: :object },
                 deleted_at: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 account: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     uuid: { type: :string },
                     title: { type: :string },
                     guid: { type: :string },
                     logo: { type: :string },
                     deleted_at: { type: :string },
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
                 },
                 assessment_action_results: { type: :array, items: { type: :object } }
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

    put 'Update Assessment' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :id, in: :path, type: :string
      parameter name: :assessment, in: :body, schema: {
        type: :object,
        properties: {
          assessment: {
            type: :object,
            properties: {
              title: { type: :string },
              account_id: { type: :integer },
              form_data: { type: :object }
            },
            required: %w[title form_data]
          }
        },
        required: %w[assessment]
      }

      response '200', 'Assessment Updated' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 message: { type: :string }
               },
               required: %w[id message]

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

  path '/api/v1/assessments/trigger_tis_api' do
    post 'Call TIS APIs' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      response '200', 'Assessment Processed Successfully.' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               }

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
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
