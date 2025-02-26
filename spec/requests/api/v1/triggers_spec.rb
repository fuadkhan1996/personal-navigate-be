# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Activities::TriggersController' do
  path '/api/v1/triggers' do
    post 'Create Trigger' do
      tags 'Triggers'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :trigger, in: :body, schema: {
        type: :object,
        properties: {
          trigger: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              nav_questionnaire_id: { type: :integer },
              criteria: {
                type: :object,
                properties: {
                  conjunction: { type: :string, enum: %w[and] },
                  conditions: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        key: { type: :string },
                        operator: { type: :string, enum: %w[eq gt gteq lteq] },
                        value: { type: :string }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      response '201', 'Trigger Created' do
        schema '$ref' => '#/components/schemas/TriggerBlueprint'
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

    get 'Get All Triggers' do
      tags 'Triggers'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      response '200', 'List of Triggers' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/TriggerBlueprint' }
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/triggers/{id}' do
    get 'Get Trigger' do
      tags 'Triggers'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]
      parameter name: :id, in: :path, type: :string

      response '200', 'Trigger Data' do
        schema '$ref' => '#/components/schemas/TriggerBlueprintExtended'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
