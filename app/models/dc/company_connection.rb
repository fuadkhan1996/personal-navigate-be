# frozen_string_literal: true

module Dc
  class CompanyConnection < ApplicationRecord
    self.table_name = :dc_company_connections

    belongs_to :company, foreign_key: :dc_company_id, inverse_of: :company_connections
    belongs_to :partner_company,
               class_name: 'Company',
               foreign_key: :dc_partner_company_id,
               inverse_of: :partner_company_connections

    has_many :assigned_company_employees,
             class_name: 'AssignedCompanyEmployee',
             inverse_of: :company_connection,
             dependent: :destroy

    has_many :company_employees, through: :assigned_company_connections

    scope :connections_between, lambda { |company_id, partner_company_id|
      where(dc_company_id: company_id, dc_partner_company_id: partner_company_id)
        .or(where(dc_company_id: company_id, dc_partner_company_id: partner_company_id))
    }

    def self.find_connection_between(company_id, partner_company_id)
      connections_between(company_id, partner_company_id).first
    end
  end
end
