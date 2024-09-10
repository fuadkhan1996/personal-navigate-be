require 'swagger_helper'

describe 'Api::V1::UploadsController' do
  path '/api/v1/uploads' do
    post 'Upload File' do
      tags 'Upload'
      consumes 'multipart/form-data'
      produces 'application/json'
      security [{ bearerAuth: [], apiKeyAuth: [] }]

      parameter name: :file, in: :formData, schema: {
        type: :object,
        properties: {
          file: {
            type: :string,
            format: :binary
          }
        }
      }, required: true

      response '200', 'File Attached Successfully.' do
        schema type: :object,
               properties: {
                 key: { type: :string }
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
