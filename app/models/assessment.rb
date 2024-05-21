# frozen_string_literal: true

class Assessment < ApplicationRecord
  self.table_name = :nav_assessments

  belongs_to :questionnaire, foreign_key: :nav_questionnaire_id, inverse_of: :assessments

  # attr_accessor :dc_company_id, :dc_employee_id, :account_id

  validates :account_id, :title, presence: true

  def account
    @account ||= Dc::Company.find(account_id)
  end

  def company_employee
    @company_employee ||= Dc::Employee.find_by_company_employee_id(dc_company_employee_id)
  end
end
