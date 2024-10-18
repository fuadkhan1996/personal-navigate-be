# frozen_string_literal: true

class Assessment < ApplicationRecord
  self.table_name = :nav_assessments

  belongs_to :questionnaire, foreign_key: :nav_questionnaire_id, inverse_of: :assessments
  belongs_to :company, class_name: 'Dc::Company', foreign_key: :dc_company_id, inverse_of: :assessments
  belongs_to :account, class_name: 'Dc::Company', inverse_of: :assessments, optional: true
  belongs_to :company_employee,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_company_employee_id,
             inverse_of: :assessments

  has_many :activity_triggers, through: :questionnaire
  has_many :assessment_action_results,
           dependent: :restrict_with_exception,
           class_name: 'Assessment::ActionResult',
           foreign_key: :nav_assessment_id,
           inverse_of: :assessment

  has_many :activity_actions, through: :assessment_action_results
  has_many :activities, through: :activity_actions, source: :activity

  validates :title, presence: true

  def status
    completed_at.present? ? 'Complete' : 'New'
  end
end
