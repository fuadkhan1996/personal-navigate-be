# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  self.table_name = :nav_questionnaires

  attr_accessor :dc_company,
                :dc_company_employee

  has_many :questionnaire_actions,
           dependent: :restrict_with_exception,
           class_name: 'Questionnaire::Action',
           foreign_key: :nav_questionnaire_id,
           inverse_of: :questionnaire

  has_many :actions, through: :questionnaire_actions
  has_many :assessments, inverse_of: :questionnaire, dependent: :restrict_with_exception

  validates :dc_company_id, :dc_company_employee_id, presence: true
end
