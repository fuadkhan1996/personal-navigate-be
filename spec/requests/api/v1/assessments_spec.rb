require 'swagger_helper'

describe 'Api::V1::Assessments' do
  path '/api/v1/assessments' do
    post 'Create Assessment' do
      tags 'Assessments'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: :assessment, in: :body, schema: {
        type: :object,
        properties: {
          assessment: {
            type: :object,
            properties: {
              title: { type: :string },
              account_id: { type: :string },
              form_data: { type: :object }
            },
            required: %w[title account_id form_data]
          }
        },
        required: %w[assessment]
      }

      response '201', 'Assessment Created' do
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

  path '/api/v1/assessments/{assessment_id}' do
    get 'Get Assessment' do
      tags 'Assessments'
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
