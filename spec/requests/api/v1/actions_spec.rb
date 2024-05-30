require 'swagger_helper'

describe 'Api::V1::Actions' do
  path '/api/v1/actions' do
    get 'Get All Actions' do
      tags 'Actions'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

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
                           id: { type: :string },
                           title: { type: :string },
                           description: { type: :string },
                           action_kind: { type: :string },
                           deleted_at: { type: :string },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
                         required: %w[id title description action_kind deleted_at created_at updated_at]
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
