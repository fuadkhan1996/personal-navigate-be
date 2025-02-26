# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::AssociatedActivities' do
  path '/api/v1/associated_activities/{associated_activity_id}/associated_activity_actions/{id}' do
    put 'Update Associated Activity Action' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :associated_activity_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :associated_activity, in: :body, schema: {
        type: :object,
        properties: {
          associated_activity_action: {
            type: :object,
            properties: {
              result_data: {
                type: :object,
                properties: {
                  data: {
                    type: :array,
                    items: { type: :object }
                  }
                }
              }
            }
          }
        }
      }

      response '200', 'Associated Activity Action Updated' do
        schema '$ref' => '#/components/schemas/AssociatedActivity::ActionBlueprint'
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
