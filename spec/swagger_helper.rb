# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.to_s + '/swagger'

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Navigate API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          bearerAuth: {
            type: 'http',
            scheme: 'bearer',
            bearerFormat: 'JWT'
          },
          apiKeyAuth: {
            type: :apiKey,
            name: 'Company-Id',
            in: :header
          },
          xApiKey: {
            type: :apiKey,
            name: 'x-api-key',
            in: :header
          }
        }
      },
      security: [
        { bearerAuth: [] },
        { apiKeyAuth: [] },
        { xApiKey: [] }
      ]
    }
  }

  config.openapi_format = :yaml
end
