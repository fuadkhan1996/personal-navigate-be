require 'swagger_helper'

describe 'Api::V1::ActionTypes' do
  path '/api/v1/action_types' do
    get 'Get Action Types' do
      tags 'Actions'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'Action Types List' do
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
                           title: { type: :string },
                           description: { type: :string },
                           action_kind: { type: :string },
                           deleted_at: { type: :string },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
                         required: %w[id title description action_kind created_at updated_at]
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
