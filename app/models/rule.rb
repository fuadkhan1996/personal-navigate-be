# frozen_string_literal: true

class Rule < ApplicationRecord
  self.table_name = :nav_rules

  attr_accessor :dc_company,
                :dc_company_employee

  validates :dc_company_id, :dc_company_employee_id, presence: true
end
