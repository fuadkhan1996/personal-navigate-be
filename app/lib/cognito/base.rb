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
      # credentials = Aws::Credentials.new(client_id.to_s, client_secret.to_s)
      @cognito_client = Aws::CognitoIdentityProvider::Client.new
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

    def self.admin_create_user(user_object:)
      new(user_object:).admin_create_user
    end

    def self.admin_set_user_password(user_object:)
      new(user_object:).admin_set_user_password
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

    def admin_create_user
      auth_object = {
        user_pool_id:,
        username: user_object[:username],
        temporary_password: user_object[:password],
        message_action: 'SUPPRESS',
        user_attributes: create_user_attributes
      }

      cognito_client.admin_create_user(auth_object)
    end

    def admin_set_user_password
      params = {
        user_pool_id:,
        username: user_object[:username],
        password: user_object[:password],
        permanent: user_object[:permanent] || true
      }

      cognito_client.admin_set_user_password(params)
    end

    private

    def create_user_attributes
      [
        {
          name: 'email',
          value: user_object[:username]
        },
        {
          name: 'email_verified',
          value: 'True'
        },
        {
          name: 'phone_number',
          value: user_object[:phone_number] || ''
        }
      ]
    end
  end
end
