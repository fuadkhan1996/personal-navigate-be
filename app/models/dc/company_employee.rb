# frozen_string_literal: true

module Dc
  class CompanyEmployee < ApplicationRecord
    self.table_name = :dc_company_employees

    include UuidGenerator
    include Invitable

    belongs_to :employee, foreign_key: :dc_employee_id, inverse_of: :company_employees
    belongs_to :company, foreign_key: :dc_company_id, inverse_of: :company_employees
    belongs_to :invited_by, polymorphic: true, optional: true

    has_one :company_type, through: :company
    has_many :assessments,
             dependent: :restrict_with_exception,
             class_name: '::Assessment',
             foreign_key: :dc_company_employee_id,
             inverse_of: :company_employee

    has_many :activities,
             dependent: :restrict_with_exception,
             class_name: '::Activity',
             foreign_key: :dc_company_employee_id,
             inverse_of: :company_employee

    has_many :assigned_company_employees,
             class_name: 'AssignedCompanyEmployee',
             inverse_of: :company_employee,
             dependent: :destroy

    has_many :assigned_company_connections, through: :assigned_company_employees, source: :company_connection

    # only accounts for now
    has_many :assigned_companies, through: :assigned_company_connections, source: :partner_company

    validates :dc_employee_id, uniqueness: { scope: :dc_company_id }

    before_create :set_employee_type, if: :company_account?

    accepts_nested_attributes_for :employee, reject_if: :blank?

    scope :by_email, ->(email) { joins(:employee).where(dc_employees: { email: email.to_s }) }
    scope :by_company_type, lambda { |company_type_name|
      joins(:company_type)
        .where(dc_company_types: { name: company_type_name.to_s })
    }

    scope :company_type_not_in, lambda { |company_type_names|
      joins(:company_type)
        .where.not(dc_company_types: { name: company_type_names })
    }

    scope :by_employee_type, ->(employee_type) { where(employee_type:) }

    scope :order_by_created_at, ->(order = :asc) { order("dc_company_employees.created_at #{order}") }
    scope :active, -> { where(dc_company_employees: { deleted_at: nil }) }

    delegate :fullname,
             :first_name,
             :last_name,
             :email,
             to: :employee

    delegate :name, to: :company_type, prefix: true
    delegate :linked_companies, :account?, to: :company, prefix: true, allow_nil: true

    def self.find_for_email_and_company_type(email:, company_type_name:)
      all.by_email(email).by_company_type(company_type_name).order_by_created_at.first
    end

    def ability
      Ability.new(self)
    end

    private

    def set_employee_type
      return if employee_type.present?

      self.employee_type = company.company_employees.exists? ? 'SME' : 'Insured'
    end
  end
end
