# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Assessments::TriggersController' do
  path '/api/v1/assessments/{assessment_id}/triggers/{id}/evaluate_trigger' do
    post 'Evaluate Trigger' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :assessment_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Trigger Evaluated Successfully.' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/AssociatedActivityBlueprint' }

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               },
               required: %w[success message]

        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end

  path '/api/v1/assessments/{assessment_id}/triggers/evaluate_triggers' do
    post 'Evaluate Triggers' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [], xApiKey: [] }]

      parameter name: :assessment_id, in: :path, type: :string
      response '200', 'Triggers Evaluated Successfully.' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/AssociatedActivityBlueprint' }

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               },
               required: %w[success message]

        run_test!
      end

      response '401', 'Unauthorized' do
        schema '$ref' => '#/components/schemas/GeneralError'
        run_test!
      end
    end
  end
end
