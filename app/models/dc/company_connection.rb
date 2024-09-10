# frozen_string_literal: true

module Dc
  class CompanyConnection < ApplicationRecord
    self.table_name = :dc_company_connections

    belongs_to :company, foreign_key: :dc_company_id, inverse_of: :company_connections
    belongs_to :partner_company,
               class_name: 'Company',
               foreign_key: :dc_partner_company_id,
               inverse_of: :partner_company_connections
  end
end
