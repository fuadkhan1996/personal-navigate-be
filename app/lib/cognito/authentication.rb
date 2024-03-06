# frozen_string_literal: true

module Cognito
  module Authentication
    include Cognito::AuthHelper

    def authenticate
      auth_object = build_auth_object
      init_auth_response = cognito_client.initiate_auth(auth_object)

      handle_custom_auth_flow(init_auth_response) if custom_auth_flow?(auth_object)

      { success: true, data: init_auth_response.authentication_result }
    rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException => e
      { success: false, message: e.message }
    end

    private

    def handle_custom_auth_flow(init_auth_response)
      verify_password_challenge(init_auth_response)
      update_user_object(init_auth_response)
      final_auth_response = process_auth_challenge(init_auth_response)
      verify_new_password_requirement(final_auth_response)
    end

    def verify_password_challenge(init_auth_response)
      raise unless init_auth_response.challenge_name == 'PASSWORD_VERIFIER'
    end

    def update_user_object(init_auth_response)
      user_object[:challenge_name] = init_auth_response.challenge_name
      user_object[:session] = init_auth_response.session
    end

    def process_auth_challenge(init_auth_response)
      respond_to_auth_challenge(process_challenge(init_auth_response.challenge_parameters))
    end

    def build_auth_object
      {
        client_id: client_id.to_s,
        auth_flow: user_object[:auth_flow] || 'CUSTOM_AUTH',
        auth_parameters: auth_parameters.to_h
      }
    end

    def custom_auth_flow?(auth_object)
      auth_object[:auth_flow] == 'CUSTOM_AUTH'
    end

    def verify_new_password_requirement(auth_response)
      raise 'new password required' if auth_response.challenge_name == 'NEW_PASSWORD_REQUIRED'
    end
  end
end
