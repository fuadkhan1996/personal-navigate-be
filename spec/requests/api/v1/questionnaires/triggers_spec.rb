# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Questionnaires::TriggersController' do
  path '/api/v1/questionnaires/{questionnaire_id}/triggers' do
    get 'Get Questionnaire Triggers' do
      tags 'Questionnaires'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :questionnaire_id, in: :path, type: :string
      response '200', 'Questionnaire triggers List' do
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
end
