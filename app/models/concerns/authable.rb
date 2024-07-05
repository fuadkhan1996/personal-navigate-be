# frozen_string_literal: true

module Authable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def authenticate(email, password)
      response = Cognito::Base.authenticate(user_object: authentication_object(email, password).to_h)
      authentication_response(response)
    end

    def refresh_access_token(cognito_username, refresh_token)
      response = Cognito::Base.authenticate(user_object: refresh_token_object(cognito_username, refresh_token).to_h)
      authentication_response(response)
    end

    def find_by_access_token(access_token)
      cognito_user = Cognito::Base.get_user(access_token: access_token.to_s)
      return if cognito_user.blank?

      find_by_email(cognito_user[:email])
    end

    private

    def authentication_object(email, password)
      {
        username: email.to_s,
        password: password.to_s,
        auth_flow: 'USER_PASSWORD_AUTH'
      }.to_h
    end

    def refresh_token_object(cognito_username, refresh_token)
      {
        username: cognito_username.to_s,
        refresh_token: refresh_token.to_s,
        auth_flow: 'REFRESH_TOKEN_AUTH'
      }.to_h
    end

    def authentication_response(response)
      return { error: response[:message] } unless response[:success]

      data = response[:data]
      {
        access_token: data.access_token,
        refresh_token: data.refresh_token,
        token_expires_in: data.expires_in
      }
    end
  end
end
