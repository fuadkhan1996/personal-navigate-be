# frozen_string_literal: true

module Cognito
  module AuthHelper
    include Cognito::Credentials
    include Cognito::Constants
    include Cognito::SharedHelper

    private

    def respond_to_auth_challenge(challenge_response)
      params = {
        client_id: client_id.to_s,
        challenge_name: user_object[:challenge_name],
        session: user_object[:session],
        challenge_responses: challenge_response
      }

      auth_response = cognito_client.respond_to_auth_challenge(params)
      raise 'new password required' if auth_response.challenge_name == 'NEW_PASSWORD_REQUIRED'

      auth_response
    end

    def process_challenge(challenge_parameters)
      user_id_for_srp = challenge_parameters.fetch('USER_ID_FOR_SRP')
      salt_hex = challenge_parameters.fetch('SALT')
      srp_b_hex = challenge_parameters.fetch('SRP_B')
      secret_block_b64 = challenge_parameters.fetch('SECRET_BLOCK')

      timestamp = current_timestamp
      signature_string = calculate_signature(user_id_for_srp, salt_hex, srp_b_hex, secret_block_b64, timestamp)

      challenge_response(timestamp, user_id_for_srp, secret_block_b64, signature_string)
    end

    def get_password_authentication_key(username, password, server_b_value, salt)
      u_value = calculate_u(@large_a_value, server_b_value)
      raise 'U cannot be zero.' if u_value.zero?

      x_value = calculate_x_value(username, password, salt)
      s_value = calculate_s_value(server_b_value, u_value, x_value)
      compute_hkdf(hex_to_bytes(pad_hex(s_value)), hex_to_bytes(pad_hex(long_to_hex(u_value))))
    end

    def calculate_x_value(username, password, salt)
      username_password = "#{user_pool_id.split('_')[1]}#{username}:#{password}"
      username_password_hash = hash_sha256(username_password)
      hex_to_long(hex_hash(pad_hex(salt) + username_password_hash))
    end

    def calculate_s_value(server_b_value, u_value, x_value)
      g_mod_pow_xn = @g.pow(x_value, @big_n)
      int_value2 = server_b_value - (@k * g_mod_pow_xn)
      int_value2.pow((@small_a_value + (u_value * x_value)), @big_n)
    end

    def compute_hkdf(ikm, salt)
      prk = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), salt, ikm)
      info_bits_update = INFO_BITS + 1.chr.force_encoding('utf-8')
      hmac_hash = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), prk, info_bits_update)
      hmac_hash.first(16)
    end

    def calculate_u(big_a, big_b)
      u_hex_hash = hex_hash(pad_hex(big_a) + pad_hex(big_b))
      hex_to_long(u_hex_hash)
    end

    def calculate_a
      big_a = @g.pow(@small_a_value, @big_n)
      raise 'Safety check for A failed' if (big_a % @big_n).zero?

      big_a
    end

    def auth_parameters
      auth_params = { SECRET_HASH: secret_hash(user_object[:username]) }
      if user_object[:auth_flow] == 'REFRESH_TOKEN_AUTH'
        return auth_params.merge(REFRESH_TOKEN: user_object[:refresh_token])
      end

      auth_params.merge(
        USERNAME: user_object[:username],
        PASSWORD: user_object[:password],
        CHALLENGE_NAME: 'SRP_A',
        SRP_A: long_to_hex(@large_a_value)
      )
    end

    def confirm_mfa_challenge_response
      {
        SECRET_HASH: secret_hash(user_object[:username]),
        USERNAME: user_object[:username],
        ANSWER: user_object[:mfa_code]
      }
    end

    def calculate_signature(user_id_for_srp, salt_hex, srp_b_hex, secret_block_b64, timestamp)
      hkdf = get_password_authentication_key(user_id_for_srp, user_object[:password], srp_b_hex.to_i(16), salt_hex)
      msg = build_msg(user_id_for_srp, secret_block_b64, timestamp)
      hmac_digest = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), hkdf, msg)
      Base64.strict_encode64(hmac_digest).force_encoding('utf-8')
    end

    def build_msg(user_id_for_srp, secret_block_b64, timestamp)
      secret_block_bytes = Base64.strict_decode64(secret_block_b64)
      "#{user_pool_id.split('_')[1]}#{user_id_for_srp}#{secret_block_bytes}#{timestamp}"
    end

    def challenge_response(timestamp, user_id_for_srp, secret_block_b64, signature_string)
      {
        TIMESTAMP: timestamp,
        USERNAME: user_id_for_srp,
        PASSWORD_CLAIM_SECRET_BLOCK: secret_block_b64,
        PASSWORD_CLAIM_SIGNATURE: signature_string,
        SECRET_HASH: secret_hash(user_id_for_srp)
      }
    end

    def current_timestamp
      Time.now.utc.strftime('%a %b %-d %H:%M:%S %Z %Y')
    end
  end
end
