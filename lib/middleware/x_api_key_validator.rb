# frozen_string_literal: true

class XApiKeyValidator
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    # Only apply middleware if the request path starts with /api/ and non-development enivronments
    if !Rails.env.development? && request.path.start_with?('/api/')
      # Fetch the X-API-KEY from request headers
      api_key = request.get_header('HTTP_X_API_KEY')

      # Check if the X-API-KEY header is present and matches the value in Rails.credentials
      if api_key.blank? || api_key != Rails.application.credentials[:x_api_key]
        Rails.logger.warn('Blocked request due to missing or invalid X-API-KEY')
        return [
          403,
          { 'Content-Type' => 'application/json' },
          [{ error: 'Forbidden' }.to_json]
        ]
      end
    end

    # Proceed with the request if the API key is valid or if it's not an API request
    @app.call(env)
  end
end
