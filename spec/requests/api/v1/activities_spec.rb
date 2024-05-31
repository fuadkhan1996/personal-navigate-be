require 'swagger_helper'

describe 'Api::V1::Activities' do
  path '/api/v1/activities' do
    post 'Create Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :activity, in: :body, schema: {
        type: :object,
        properties: {
          activity: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              activity_actions_attributes: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    title: { type: :string },
                    description: { type: :string },
                    details: { type: :object },
                    order: { type: :integer },
                    nav_action_id: { type: :integer }
                  }
                }
              }
            }
          }
        },
        required: %w[activity]
      }

      response '201', 'Activity Created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 message: { type: :string }
               },
               required: %w[id message]

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
