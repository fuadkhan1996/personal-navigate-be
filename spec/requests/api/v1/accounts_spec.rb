require 'swagger_helper'

describe 'Api::V1::Accounts' do
  path '/api/v1/accounts' do
    get 'Get Accounts' do
      tags 'Accounts'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'Accounts List' do
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
                           uuid: { type: :string },
                           logo: { type: :string },
                           title: { type: :string },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
                         required: %w[id uuid logo title deleted_at created_at updated_at]
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
