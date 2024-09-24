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
                       updated_at: { type: :string }
                     },
                     required: %w[id uuid title logo deleted_at created_at updated_at]
                   }
                 },
                 required: %w[id title form_data deleted_at created_at updated_at account]
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
                     updated_at: { type: :string }
                   },
                   required: %w[id uuid title logo deleted_at created_at updated_at]
                 },
                 assessment_action_results: { type: :array, items: { type: :object } }
               },
               required: %w[id title form_data deleted_at created_at updated_at account assessment_action_results]

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
end
