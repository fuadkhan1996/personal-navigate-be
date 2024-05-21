# frozen_string_literal: true

module Dc
  class Company
    include ActiveModel::API
    include Dc::Api::Company

    def initialize(attributes)
      attributes.each do |key, value|
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", value)
      end
    end

    def self.find(id)
      query = ActiveRecord::Base.sanitize_sql_array([<<-SQL.squish, id])
        SELECT * FROM dc_companies WHERE id = ? LIMIT 1
      SQL

      new(ApplicationRecord.connection.execute(query).try(:first))
    end

    def linked_accounts
      query = ActiveRecord::Base.sanitize_sql_array([<<-SQL.squish, id])
      SELECT dc_companies.*, dc_company_types.name as company_type_name FROM dc_companies
        INNER JOIN dc_company_connections ON dc_company_connections.dc_partner_company_id = dc_companies.id
        INNER JOIN dc_company_types ON dc_company_types.id = dc_companies.comp_type_id
        WHERE dc_company_types.name = 'Account' AND dc_company_connections.dc_company_id = ?
      SQL

      results = ApplicationRecord.connection.execute(query)
      results.map { |record| self.class.new(record) }
    end
  end
end
