# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::AssociatedActivities' do
  path '/api/v1/associated_activities' do
    post 'Create Associated Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_id, in: :query, type: :string
      parameter name: :associated_activity, in: :body, schema: {
        type: :object,
        properties: {
          associated_activity: {
            type: :object,
            properties: {
              activity_id: { type: :string }
            }
          }
        }
      }

      response '201', 'Associated Activity Created' do
        schema '$ref' => '#/components/schemas/AssociatedActivityBlueprint'
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

    get 'Get Associated Activities' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :company_id, in: :query, type: :string
      parameter name: :assessment_id, in: :query, type: :string
      parameter name: :action_kind, in: :query, type: :string, description: 'file_upload/alert'

      response '200', 'Associated Activities' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/AssociatedActivityBlueprint' }

        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/associated_activities/{id}' do
    get 'Get Associated Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :id, in: :path, type: :string

      response '200', 'Associated Activity' do
        schema '$ref' => '#/components/schemas/AssociatedActivityBlueprint'
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

    put 'Update Associated Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :id, in: :path, type: :string
      parameter name: :associated_activity, in: :body, schema: {
        type: :object,
        properties: {
          associated_activity: {
            type: :object,
            properties: {
              pinned: { type: :boolean }
            }
          }
        }
      }

      response '200', 'Updated Associated Activity' do
        schema '$ref' => '#/components/schemas/AssociatedActivityBlueprint'
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
