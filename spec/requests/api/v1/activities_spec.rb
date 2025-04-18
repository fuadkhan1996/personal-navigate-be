# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Activities' do
  path '/api/v1/activities' do
    get 'Get Activities' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :action_kind, in: :query, type: :string, description: 'file_upload/alert'
      response '200', 'Activity List' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/ActivityBlueprintNormal' }
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/activities' do
    post 'Create Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :activity, in: :body, schema: {
        type: :object,
        properties: {
          activity: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              trigger_ids: { type: :array, items: { type: :string } },
              activity_actions_attributes: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    title: { type: :string },
                    description: { type: :string },
                    details: { type: :object },
                    document_keys: {
                      type: :array,
                      items: { type: :string }
                    },
                    order: { type: :integer },
                    linked_action_kind: { type: :string }
                  }
                }
              }
            }
          }
        },
        required: %w[activity]
      }

      response '201', 'Activity Created' do
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

  path '/api/v1/activities/{id}' do
    get 'Get Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :id, in: :path, type: :string
      response '200', 'Activity Data' do
        schema '$ref' => '#/components/schemas/ActivityBlueprintExtended'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
