# frozen_string_literal: true

module Nav
  class Questionnaire < ApplicationRecord
    self.table_name = :nav_questionnaires

    attr_accessor :dc_company,
                  :dc_company_employee

    validates :dc_company_id, :dc_company_employee_id, presence: true
  end
end
