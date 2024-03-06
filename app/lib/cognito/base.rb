# frozen_string_literal: true

module Cognito
  class Base
    attr_accessor :cognito_client,
                  :user_object,
                  :access_token,
                  :refresh_token

    include Cognito::Credentials
    include Cognito::Authentication

    def initialize(user_object: nil, access_token: nil, refresh_token: nil)
      credentials = Aws::Credentials.new(client_id.to_s, client_secret.to_s)
      # rubocop:disable Style/HashSyntax
      @cognito_client = Aws::CognitoIdentityProvider::Client.new(credentials: credentials)
      # rubocop:enable Style/HashSyntax
      @user_object = user_object
      @access_token = access_token
      @refresh_token = refresh_token
      @big_n = hex_to_long(N_HEX)
      @g = hex_to_long(G_HEX)
      @k = hex_to_long(hex_hash("00#{N_HEX}0#{G_HEX}"))
      @small_a_value = generate_random_small_a
      @large_a_value = calculate_a
    end

    def self.authenticate(user_object: nil, refresh_token: nil)
      new(user_object: user_object.to_h, refresh_token: refresh_token.to_s).authenticate
    end

    def self.get_user(access_token:)
      new(access_token: access_token.to_s).user
    end

    def self.sign_out(access_token:)
      new(access_token: access_token.to_s).sign_out
    end

    def sign_out
      cognito_client.global_sign_out(access_token: access_token.to_s)
    end

    def user
      user = cognito_client.get_user(access_token: access_token.to_s)
      user_attrs = {}
      JSON.parse(user.user_attributes.to_json).each { |attr| user_attrs[attr['name'].to_sym] = attr['value'] }
      user_attrs
    end
  end
end
