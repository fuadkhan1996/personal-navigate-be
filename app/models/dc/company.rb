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

    scope :by_company_type, lambda { |company_type_name|
      joins(:company_type)
        .where(dc_company_types: { name: company_type_name })
    }

    delegate :name, to: :company_type, prefix: true, allow_nil: true
    delegate :by_email, to: :company_employees, prefix: true, allow_nil: true
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
  end
end
