# frozen_string_literal: true

module Authable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def authenticate(email, password)
      user_object = {
        username: email.to_s,
        password: password.to_s,
        auth_flow: 'USER_PASSWORD_AUTH'
      }

      response = Cognito::Base.authenticate(user_object: user_object.to_h)
      if response[:success]
        { access_token: response[:data].access_token, refresh_token: response[:data].refresh_token }
      else
        { error: response[:message] }
      end
    end

    def get_user(access_token:)
      cognito_user = Cognito::Base.get_user(access_token: access_token.to_s)
      find_by_email(cognito_user[:email])
    end
  end
end
