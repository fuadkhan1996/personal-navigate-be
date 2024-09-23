# frozen_string_literal: true

module Dc
  class Employee < ApplicationRecord
    include Authable

    self.table_name = :dc_employees

    has_many :company_employees,
             dependent: :restrict_with_exception,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_employee_id,
             inverse_of: :employee

    has_many :companies, through: :company_employees

    def fullname
      [first_name, last_name].join(' ')
    end
  end
end
