require 'swagger_helper'

describe 'Api::V1::Activities' do
  path '/api/v1/activities' do
    get 'Get Activities' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'Activity List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string },
                   title: { type: :string },
                   description: { type: :string },
                   deleted_at: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id title description deleted_at created_at updated_at]
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

  path '/api/v1/activities/{id}' do
    get 'Get Activity' do
      tags 'Activities'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :id, in: :path, type: :string
      response '200', 'Activity Data' do
        schema type: :object,
               properties: {
                 id: { type: :string },
                 title: { type: :string },
                 description: { type: :string },
                 deleted_at: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 activity_actions: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       title: { type: :string },
                       description: { type: :string },
                       order: { type: :integer },
                       details: { type: :object },
                       action_kind: { type: :string },
                       deleted_at: { type: :string },
                       created_at: { type: :string },
                       updated_at: { type: :string }
                     },
                     required: %w[id title description order details action_kind deleted_at created_at updated_at]
                   }
                 },
                 activity_triggers: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
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
                     }
                   }
                 }
               },
               required: %w[id title description deleted_at created_at updated_at activity_actions activity_triggers]

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
