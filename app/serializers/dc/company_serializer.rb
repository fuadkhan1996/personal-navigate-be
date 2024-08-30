# frozen_string_literal: true

module Dc
  class CompanySerializer
    include JSONAPI::Serializer

    attributes :id, :uuid, :title, :logo, :company_type_name, :deleted_at, :created_at, :updated_at
  end
end
