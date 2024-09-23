# frozen_string_literal: true

module Dc
  class Company < ApplicationRecord
    self.table_name = :dc_companies

    belongs_to :company_type, foreign_key: :comp_type_id, inverse_of: :companies
    has_many :company_employees,
             dependent: :restrict_with_exception,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_company_id,
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

    validates :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }, unless: :company_type_account?
    validates_associated :partner_company_connections, on: :create, if: :company_type_account?
    validates_associated :company_employees, on: :create

    accepts_nested_attributes_for :company_employees, reject_if: :blank?, allow_destroy: true
    accepts_nested_attributes_for :partner_company_connections, reject_if: :blank?, allow_destroy: true

    before_create :set_company_code

    scope :by_company_type, lambda { |company_type_name|
      joins(:company_type)
        .where(dc_company_types: { name: company_type_name })
    }

    delegate :name, :account?, to: :company_type, prefix: true, allow_nil: true
    delegate :by_email, to: :company_employees, prefix: true, allow_nil: true
    delegate :email, to: :company_employees, allow_nil: true
    delegate :by_company_type, to: :linked_companies, prefix: true, allow_nil: true

    def linked_companies
      company_ids = company_connections.pluck(:dc_partner_company_id) +
                    partner_company_connections.pluck(:dc_company_id)
      Company.where(id: company_ids)
    end

    def assessments
      if company_type_name == 'Account'
        Assessment.where(account_id: id)
      else
        Assessment.where(dc_company_id: id)
      end
    end

    private

    def set_company_code
      loop do
        self.company_code = SecureRandom.alphanumeric(8)
        break if self.class.find_by(company_code:).blank?
      end

      company_code
    end
  end
end
