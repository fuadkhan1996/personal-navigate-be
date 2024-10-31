# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Assessments::TriggersController' do
  path '/api/v1/assessments/{assessment_id}/triggers/{id}/evaluate_trigger' do
    post 'Evaluate Trigger' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :assessment_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'Trigger Evaluated Successfully.' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   activity_action_id: { type: :integer },
                   completed_at: { type: :string },
                   status: { type: :string },
                   assessment_id: { type: :integer },
                   result_data: { type: :object },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   activity: { type: :object },
                   activity_triggers: {
                     type: :array,
                     items: { type: :object }
                   },
                   activity_action: { type: :object }
                 }
               }

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
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        run_test!
      end
    end
  end

  path '/api/v1/assessments/{assessment_id}/triggers/evaluate_triggers' do
    post 'Evaluate Trigger' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :assessment_id, in: :path, type: :string
      response '200', 'Triggers Evaluated Successfully.' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   activity_action_id: { type: :integer },
                   completed_at: { type: :string },
                   status: { type: :string },
                   assessment_id: { type: :integer },
                   result_data: { type: :object },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   activity: { type: :object },
                   activity_triggers: {
                     type: :array,
                     items: { type: :object }
                   },
                   activity_action: { type: :object }
                 }
               }

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
