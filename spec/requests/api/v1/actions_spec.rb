# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::ActionsController' do
  path '/api/v1/actions' do
    get 'Get All Actions' do
      tags 'Actions'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      response '200', 'Actions List' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/ActionBlueprint' }

        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
