# frozen_string_literal: true

module Dc
  class Company < ApplicationRecord
    self.table_name = :dc_companies

    include UuidGenerator

    belongs_to :company_type, foreign_key: :comp_type_id, inverse_of: :companies
    has_many :company_employees,
             dependent: :restrict_with_exception,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_company_id,
             inverse_of: :company

    has_many :active_company_employees, lambda {
      active
    }, dependent: :restrict_with_exception,
       class_name: 'Dc::CompanyEmployee',
       inverse_of: :company

    has_many :employees, through: :company_employees
    has_many :activities,
             dependent: :restrict_with_exception,
             class_name: '::Activity',
             foreign_key: :dc_company_id,
             inverse_of: :company

    has_many :company_connections,
             dependent: :restrict_with_exception,
             class_name: 'Dc::CompanyConnection',
             foreign_key: :dc_company_id,
             inverse_of: :company

    has_many :partner_company_connections,
             dependent: :restrict_with_exception,
             class_name: 'Dc::CompanyConnection',
             foreign_key: :dc_partner_company_id,
             inverse_of: :partner_company

    has_many :assessments,
             dependent: :restrict_with_exception,
             class_name: '::Assessment',
             foreign_key: :dc_company_id,
             inverse_of: :company

    has_many :activity_connections,
             dependent: :destroy,
             class_name: 'AssociatedActivity',
             inverse_of: :company

    has_many :assigned_activities, through: :activity_connections, source: :activity

    # only accounts for now
    has_many :assigned_company_employees, through: :partner_company_connections
    has_many :triggers, dependent: :destroy, class_name: '::Trigger'

    validates :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }, unless: :company_type_account?
    validates_associated :partner_company_connections, on: :create, if: :company_type_account?
    validates_associated :company_employees, on: :create
    validate :validate_title_uniqueness, on: %i[create update]

    accepts_nested_attributes_for :company_employees, reject_if: :blank?, allow_destroy: true
    accepts_nested_attributes_for :partner_company_connections, reject_if: :blank?, allow_destroy: true

    before_validation :set_guid, on: :create
    before_create :set_company_code

    scope :by_company_type, lambda { |company_type_name|
      joins(:company_type)
        .where(dc_company_types: { name: company_type_name })
    }

    delegate :name, :account?, to: :company_type, prefix: true, allow_nil: true
    delegate :account?, to: :company_type, allow_nil: true
    delegate :by_email, :by_employee_type, to: :active_company_employees, prefix: true, allow_nil: true
    delegate :email, to: :company_employees, allow_nil: true
    delegate :by_company_type, to: :linked_companies, prefix: true, allow_nil: true

    def linked_companies
      company_ids = company_connections.pluck(:dc_partner_company_id) +
                    partner_company_connections.pluck(:dc_company_id)
      Company.where(id: company_ids)
    end

    def accounts
      linked_companies.by_company_type('Account')
    end

    def assessments
      if account?
        Assessment.where(account_id: id)
      else
        Assessment.where(dc_company_id: id)
      end
    end

    def primary_company_employee
      if account?
        company_employees.where(employee_type: 'Insured').order(created_at: :asc).first
      else
        company_employees.where(employee_type: 'Admin/Owner').order(created_at: :asc).first
      end
    end

    def all_associated_activities
      # Return activity_connections if the account? condition is false
      return activity_connections unless account?

      # Fetch associated activities based on company_id or assessment_ids
      AssociatedActivity.where(company_id: id)
                        .or(AssociatedActivity.where(assessment_id: assessments.pluck(:id)))
    end

    private

    def set_company_code
      loop do
        self.company_code = SecureRandom.alphanumeric(8)
        break if self.class.find_by(company_code:).blank?
      end

      company_code
    end

    def set_guid
      self.guid = SecureRandom.uuid
    end

    def validate_title_uniqueness
      return if current_company.blank?
      return unless account?
      return unless current_company.accounts.pluck(:title).any? { |acc_title| acc_title == title }

      errors.add(:title, 'Account already exist with the same title')
    end
  end
end
