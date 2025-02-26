# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Activities::TriggersController' do
  path '/api/v1/activities/{activity_id}/triggers' do
    post 'Create Activity Trigger' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :activity_id, in: :path, type: :string
      parameter name: :activity_trigger, in: :body, schema: {
        type: :object,
        properties: {
          activity_trigger: {
            type: :object,
            properties: {
              trigger_id: { type: :string }
            }
          }
        }
      }

      response '201', 'Activity Trigger Created' do
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

    get 'Get Activity Triggers' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :activity_id, in: :path, type: :string
      response '200', 'Activity triggers List' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/ActivityTriggerBlueprint' }
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/activities/{activity_id}/triggers/{id}' do
    get 'Get Activity Trigger' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :activity_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'Activity trigger Data' do
        schema '$ref' => '#/components/schemas/ActivityTriggerBlueprint'
        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end

    delete 'Delete Activity Trigger' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :activity_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Activity trigger Deleted Successfully.' do
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
end
