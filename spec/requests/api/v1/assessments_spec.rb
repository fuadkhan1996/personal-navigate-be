require 'swagger_helper'

describe 'Api::V1::Assessments' do
  path '/api/v1/assessments/{assessment_id}' do
    get 'Get Assessment' do
      tags 'Company'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :assessment_id, in: :path, type: :string
      response '200', 'Assessment Data' do
        schema type: :object,
               properties: {
                 data: {
                  type: :object,
                  properties: {
                    id: { type: :string },
                    type: { type: :string },
                    attributes: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        title: { type: :string },
                        form_data: { type: :object },
                        account: {
                          type: :object,
                          properties: {
                            id: { type: :integer },
                            title: { type: :string }
                          }
                        },
                        deleted_at: { type: :string },
                        created_at: { type: :string },
                        updated_at: { type: :string }
                      },
                      required: %w[id title form_data account deleted_at created_at updated_at]
                    }
                  },
                  required: %w[id type attributes]
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
