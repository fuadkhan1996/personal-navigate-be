# frozen_string_literal: true

module Dc
  class EmployeeSerializer
    include JSONAPI::Serializer

    attributes :id,
               :email,
               :last_name,
               :first_name,
               :cognito_username
  end
end
