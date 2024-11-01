# frozen_string_literal: true

class Activity
  class ActionBlueprint < ApplicationBlueprint
    identifier :id

    fields :title, :description, :details, :action_kind, :order, :created_at, :updated_at

    view :with_supporting_documents do
      field :supporting_documents do |activity, _options|
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
