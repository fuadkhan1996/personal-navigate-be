# frozen_string_literal: true

module Dc
  class EmployeeSerializer
    include JSONAPI::Serializer

    attributes :id, :email, :first_name, :last_name, :access_token, :refresh_token, :cognito_username
  end
end
