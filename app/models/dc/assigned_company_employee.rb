# frozen_string_literal: true

module Dc
  class AssignedCompanyEmployee < ApplicationRecord
    self.table_name = :dc_assigned_company_employees

    belongs_to :company_employee, class_name: 'CompanyEmployee', inverse_of: :assigned_company_employees
    belongs_to :company_connection,
               class_name: 'CompanyConnection',
               inverse_of: :assigned_company_employees

    validates :company_employee_id, uniqueness: { case_sensitive: false, scope: :company_connection_id }
  end
end
