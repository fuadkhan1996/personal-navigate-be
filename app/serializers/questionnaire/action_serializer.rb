# frozen_string_literal: true

class Questionnaire
  class ActionSerializer
    include JSONAPI::Serializer

    attribute :id,
              :action_id,
              :action_title,
              :action_description,
              :criteria,
              :created_at,
              :updated_at,
              :deleted_at
  end
end
