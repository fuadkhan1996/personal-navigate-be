# frozen_string_literal: true

module Dc
  class CompanySerializer
    include JSONAPI::Serializer

    attributes :uuid, :title, :logo, :created_at, :updated_at
  end
end
