# frozen_string_literal: true

module CurrentContextHelper
  def current_company
    Current.company
  end

  def current_employee
    Current.employee
  end
end
