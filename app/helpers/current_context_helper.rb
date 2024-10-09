# frozen_string_literal: true

module CurrentContextHelper
  def current_company
    Current.company
  end

  def current_company_employee
    Current.company_employee
  end

  def current_ability
    Current.ability
  end

  def current_access_token
    Current.access_token
  end

  def current_employee
    current_company_employee.employee
  end
end
