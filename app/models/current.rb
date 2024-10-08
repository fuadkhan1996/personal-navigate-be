# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :company, :company_employee, :ability, :access_token
end
