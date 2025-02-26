# frozen_string_literal: true

class Activity
  class ActionBlueprint < ApplicationBlueprint
    api_identifier :id

    api_field :title, type: :string, required: true
    api_field :description, type: :string, required: true
    api_field :details, type: :string, required: true
    api_field :action_kind, type: :string, required: true
    api_field :order, type: :string, required: true
    api_field :created_at, type: :string, required: true
    api_field :updated_at, type: :string, required: true

    api_view :with_supporting_documents do
      api_field :supporting_documents, type: :array do |activity, _options|
        activity.supporting_documents.map do |document|
          {
            key: document.key,
            content_type: document.content_type,
            filename: document.filename.to_s,
            size: document.byte_size
          }
        end
      end
    end
  end
end
