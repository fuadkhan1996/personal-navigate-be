# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Assessments::ActionResultsController' do
  path '/api/v1/assessments/{assessment_id}/action_results/{id}' do
    put 'Evaluate Action Result' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :assessment_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :action_result, in: :body, schema: {
        type: :object,
        properties: {
          action_result: {
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

      response '200', 'Action Result Updated Successfully.' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   activity_action_id: { type: :integer },
                   completed_at: { type: :string },
                   status: { type: :string },
                   assessment_id: { type: :integer },
                   activity_trigger_id: { type: :integer },
                   result_data: { type: :object },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   activity: { type: :object },
                   activity_trigger: { type: :object },
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
                   assessment_id: { type: :integer },
                   activity_trigger_id: { type: :integer },
                   result_data: { type: :object },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   activity: { type: :object },
                   activity_trigger: { type: :object },
                   activity_action: { type: :object }
                 },
                 required: %w[
                   id
                   activity_action_id
                   assessment_id
                   activity_trigger_id
                   result_data
                   deleted_at
                   created_at
                   updated_at
                   activity
                   activity_trigger
                   activity_action
                 ]
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
