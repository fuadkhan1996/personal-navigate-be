# frozen_string_literal: true

module ApiFieldHelpers
  def api_field(name, options = {})
    field(name, options)
  end

  def api_association(name, options = {})
    association(name, **options)
  end
end

class ApplicationBlueprint < Blueprinter::Base
  include CurrentContextHelper
  extend ApiFieldHelpers
end
