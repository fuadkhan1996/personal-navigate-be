# frozen_string_literal: true

module Cognito
  module Credentials
    private

    def client_secret
      Rails.application.credentials.dig(:aws, :cognito_client_secret)
    end

    def client_id
      Rails.application.credentials.dig(:aws, :cognito_client_id)
    end

    def user_pool_id
      Rails.application.credentials.dig(:aws, :cognito_user_pool_id)
    end

    def secret_hash(username)
      Base64.encode64(
        OpenSSL::HMAC.digest(
          OpenSSL::Digest.new('sha256'), client_secret, "#{username}#{client_id}"
        )
      ).strip
    end
  end
end
