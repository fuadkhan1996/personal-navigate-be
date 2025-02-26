# frozen_string_literal: true

module Dc
  class CompanyEmployeeBlueprint < ApplicationBlueprint
    api_identifier :id

    api_field :email, type: :string, required: true
    api_field :first_name, type: :string, required: true
    api_field :last_name, type: :string, required: true
    api_field :uuid, type: :string, required: true
    api_field :created_at, type: :string, required: true
    api_field :updated_at, type: :string, required: true
    api_field :invitation_sent_at, type: :string, required: true
    api_field :invitation_accepted_at, type: :string, required: true
    api_field :employee_type, type: :string, required: true

    api_view :extended do
      api_association :company, blueprint: Dc::CompanyBlueprint
    end
  end
end
