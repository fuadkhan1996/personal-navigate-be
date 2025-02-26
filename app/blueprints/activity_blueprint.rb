# frozen_string_literal: true

class ActivityBlueprint < ApplicationBlueprint
  api_identifier :id

  api_field :title, type: :string, required: true
  api_field :description, type: :string, required: true
  api_field :deleted_at, type: :string, required: true
  api_field :created_at, type: :string, required: true
  api_field :updated_at, type: :string, required: true

  api_view :normal do
    api_association :company, blueprint: Dc::CompanyBlueprint
    api_association :company_employee, blueprint: Dc::CompanyEmployeeBlueprint
  end

  api_view :extended do
    include_api_view :normal
    api_association :activity_actions, blueprint: Activity::ActionBlueprint, view: :with_supporting_documents,
                                       type: :array
    api_association :activity_triggers, blueprint: Activity::TriggerBlueprint, type: :array
  end
end
