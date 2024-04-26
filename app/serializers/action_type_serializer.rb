# frozen_string_literal: true

class ActionTypeSerializer
  include JSONAPI::Serializer

  attribute :id, :title, :description, :action_kind, :deleted_at, :created_at, :updated_at
end
