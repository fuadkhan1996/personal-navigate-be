require 'swagger_helper'

describe 'Api::V1::Actions' do
  path '/api/v1/actions' do
    post 'Create Action' do
      tags 'Actions'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          action_payload: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              action_kind: { type: :string },
              details: { type: :object }
            },
            required: %w[title description details]
          }
        },
        required: %w[action]
      }

      response '200', 'Action data' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: %w[message]

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: {
                     type: :array,
                     items: {
                       type: :string
                     }
                   }
                 }
               },
               required: %w[errors]

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
