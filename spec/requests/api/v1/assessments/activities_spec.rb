# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Assessments::ActivitiesController' do
  path '/api/v1/assessments/activities' do
    get 'Get Activities with Action Results' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      response '200', 'Activities List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string },
                   title: { type: :string },
                   description: { type: :string },
                   assessment_id: { type: :string },
                   status: { type: :string },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   assessment_action_results: {
                     type: :array,
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
                   }
                 }
               }

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

  path '/api/v1/assessments/{assessment_id}/activities' do
    get 'Get Activities for an assessment with Action Results' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :assessment_id, in: :path, type: :string
      response '200', 'Activities List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string },
                   title: { type: :string },
                   description: { type: :string },
                   assessment_id: { type: :string },
                   status: { type: :string },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   assessment_action_results: {
                     type: :array,
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
                   }
                 }
               }

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

  path '/api/v1/assessments/{assessment_id}/activities/{id}' do
    get 'Get Activity for an assessment with Action Results' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :assessment_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'Activity Data' do
        schema type: :object,
               properties: {
                 id: { type: :string },
                 title: { type: :string },
                 description: { type: :string },
                 assessment_id: { type: :string },
                 status: { type: :string },
                 deleted_at: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 assessment_action_results: {
                   type: :array,
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
                 }
               }

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
