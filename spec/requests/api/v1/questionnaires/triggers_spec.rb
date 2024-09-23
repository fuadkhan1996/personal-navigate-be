# frozen_string_literal: true

require 'swagger_helper'

describe 'Api::V1::Questionnaires::TriggersController' do
  path '/api/v1/questionnaires/{questionnaire_id}/triggers' do
    get 'Get Questionnaire Triggers' do
      tags 'Questionnaires'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :questionnaire_id, in: :path, type: :string
      response '200', 'Questionnaire triggers List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string },
                   title: { type: :string },
                   description: { type: :string },
                   questionnaire_title: { type: :string },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   criteria: {
                     type: :object,
                     properties: {
                       conjunction: { type: :string },
                       conditions: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             key: { type: :string },
                             operator: { type: :string },
                             value: { type: :string }
                           },
                           required: %w[key operator value]
                         }
                       }
                     },
                     required: %w[conjunction conditions]
                   },
                   activity: { type: :object }
                 },
                 required: %w[id title description questionnaire_title deleted_at created_at updated_at criteria]
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
