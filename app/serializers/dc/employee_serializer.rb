# frozen_string_literal: true

module Dc
  class EmployeeSerializer
    include JSONAPI::Serializer

    attribute :id, &:company_employee_uuid
    attributes :email,
               :last_name,
               :first_name

    attribute :company do |employee|
      CompanySerializer.new(employee.company).serializable_hash[:data][:attributes] if employee.company
    end
  end
end
