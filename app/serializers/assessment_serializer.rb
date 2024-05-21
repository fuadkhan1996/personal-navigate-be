# frozen_string_literal: true

class AssessmentSerializer
  include JSONAPI::Serializer

  attribute :id, :title, :form_data, :deleted_at, :created_at, :updated_at

  attribute :account do |assessment|
    account = assessment.account
    { id: account.id, title: account.title }
  end
end
