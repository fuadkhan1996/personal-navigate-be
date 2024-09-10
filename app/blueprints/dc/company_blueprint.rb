# frozen_string_literal: true

module Dc
  class CompanyBlueprint < Blueprinter::Base
    identifier :id

    fields :id, :guid, :title, :logo, :company_type_name, :deleted_at, :created_at, :updated_at
  end
end
