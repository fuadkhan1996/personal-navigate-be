# frozen_string_literal: true

module Cognito
  module Password
    def update_password
      params = {
        access_token: current_access_token,
        previous_password: user_object[:current_password],
        proposed_password: user_object[:new_password]
      }

      cognito_client.change_password(params)
      ResponseStruct.new(status: 'success', message: 'Password updated successfully.')
    rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException
      ResponseStruct.new(status: 'failure', attribute: :current_password, message: 'Incorrect')
    rescue Aws::CognitoIdentityProvider::Errors::InvalidPasswordException
      ResponseStruct.new(status: 'failure', attribute: :password,
                         message: I18n.t('activerecord.errors.models.employee.attributes.password.invalid_format'))
    rescue Aws::CognitoIdentityProvider::Errors::LimitExceededException => e
      ResponseStruct.new(status: 'failure', attribute: :password, message: e.message)
    end
  end
end
