# frozen_string_literal: true

module Dc
  class CompanyType < ApplicationRecord
    self.table_name = :dc_company_types

    has_many :companies,
             dependent: :restrict_with_exception,
             foreign_key: :comp_type_id,
             inverse_of: :company_type

    def account?
      name == 'Account'
    end
  end
end
