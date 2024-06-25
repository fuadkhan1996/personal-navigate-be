# frozen_string_literal: true

class Assessment < ApplicationRecord
  self.table_name = :nav_assessments

  belongs_to :questionnaire, foreign_key: :nav_questionnaire_id, inverse_of: :assessments
  has_many :activity_triggers, through: :questionnaire
  has_many :assessment_action_results,
           dependent: :restrict_with_exception,
           class_name: 'Assessment::ActionResult',
           foreign_key: :nav_assessment_id,
           inverse_of: :assessment

  # attr_accessor :dc_company_id, :dc_employee_id, :account_id

  validates :account_id, :title, presence: true

  def account
    @account ||= Dc::Company.find(account_id)
  end

  def company_employee
    # rubocop:disable Rails/DynamicFindBy
    @company_employee ||= Dc::Employee.find_by_company_employee_id(dc_company_employee_id)
    # rubocop:enable Rails/DynamicFindBy
  end
end
