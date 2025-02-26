# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Assessments' do
  path '/api/v1/assessments' do
    post 'Create Assessment' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

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
        schema '$ref' => '#/components/schemas/SuccessMessageWithId'
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

    get 'Get Assessments' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :account_id, in: :query, type: :string
      response '200', 'Assessment List' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/AssessmentBlueprint' }

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
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :id, in: :path, type: :string
      response '200', 'Assessment Data' do
        schema '$ref' => '#/components/schemas/AssessmentBlueprintExtended'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end

    put 'Update Assessment' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

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
        schema '$ref' => '#/components/schemas/SuccessMessageWithId'
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

  path '/api/v1/assessments/trigger_tis_api' do
    post 'Call TIS APIs' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      response '200', 'Assessment Processed Successfully.' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               }

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
