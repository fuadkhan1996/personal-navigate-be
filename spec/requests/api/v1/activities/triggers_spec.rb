require 'swagger_helper'

describe 'Api::V1::Activities::TriggersController' do
  path '/api/v1/activities/{activity_id}/triggers' do
    post 'Create Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :activity_id, in: :path, type: :string
      parameter name: :activity_trigger, in: :body, schema: {
        type: :object,
        properties: {
          activity_trigger: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              nav_questionnaire_id: { type: :integer },
              criteria: {
                type: :object,
                properties: {
                  conjunction: { type: :string, enum: %w[and] },
                  conditions: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        key: { type: :string },
                        operator: { type: :string, enum: %w[eq gt gteq lteq] },
                        value: { type: :string }
                      },
                      required: %w[key operator value]
                    }
                  }
                },
                required: %w[conjunction conditions]
              }
            },
            required: %w[title description criteria]
          }
        },
        required: %w[activity_trigger]
      }

      response '201', 'Activity Trigger Created' do
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

    get 'Get Activity Triggers' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :activity_id, in: :path, type: :string
      response '200', 'Activity triggers List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string },
                   title: { type: :string },
                   description: { type: :string },
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
                   }
                 },
                 required: %w[id title description deleted_at created_at updated_at criteria]
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

  path '/api/v1/activities/{activity_id}/triggers/{id}' do
    get 'Get Activity Trigger' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :activity_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'Activity trigger Data' do
        schema type: :object,
               properties: {
                 id: { type: :string },
                 title: { type: :string },
                 description: { type: :string },
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
                 }
               },
               required: %w[id title description deleted_at created_at updated_at criteria]

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
