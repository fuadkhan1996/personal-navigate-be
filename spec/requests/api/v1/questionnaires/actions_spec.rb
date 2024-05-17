require 'swagger_helper'

describe 'Api::V1::Questionnaires::Actions' do
  path '/api/v1/questionnaires/{questionnaire_id}/actions' do
    post 'Attach Action to Questionnaire' do
      tags 'Questionnaires'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :questionnaire_id, in: :path, type: :string
      parameter in: :body, schema: {
        type: :object,
        properties: {
          questionnaire_action: {
            type: :object,
            properties: {
              action_id: { type: :integer },
              criteria: {
                type: :object,
                properties: {
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
                required: %w[conditions]
              }
            },
            required: %w[action_id criteria]
          }
        },
        required: %w[questionnaire_action]
      }

      response '201', 'Action Attached' do
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

    get 'Get All Actions' do
      tags 'Questionnaires'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :questionnaire_id, in: :path, type: :string

      response '200', 'Actions List' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       type: { type: :string },
                       attributes: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           action_id: { type: :integer },
                           action_title: { type: :string },
                           action_description: { type: :string },
                           deleted_at: { type: :string },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
                         required: %w[id action_id action_title action_description deleted_at created_at updated_at]
                       }
                     },
                     required: %w[id type attributes]
                   }
                 }
               },
               required: %w[data]

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
