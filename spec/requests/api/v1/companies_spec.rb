require 'swagger_helper'

describe 'Api::V1::Companies' do
  path '/api/v1/companies' do
    get 'Get Linked Companies' do
      tags 'Companies'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :company_type, in: :query, type: :string, description: 'Account/Carrier/Wholesaler/SubAgency'
      response '200', 'Companies List' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string },
                   title: { type: :string },
                   logo: { type: :string },
                   company_type_name: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id title logo company_type_name created_at updated_at]
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
