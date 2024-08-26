# frozen_string_literal: true

module Dc
  class Employee
    include ActiveModel::API
    include ActiveModel::Serialization
    include Dc::Api::Employee
    include Authable

    delegate :activities, :assessments, to: :company, prefix: true

    def initialize(attributes)
      attributes.each do |key, value|
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", value)
      end
    end

    def attributes
      instance_variables.each_with_object({}) do |var, hash|
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end
    end

    def self.find(id)
      query = ActiveRecord::Base.sanitize_sql_array([<<-SQL.squish, id])
        SELECT * FROM dc_employees WHERE id = ? LIMIT 1
      SQL

      new(ApplicationRecord.connection.execute(query).try(:first))
    end

    def self.find_by_email(email)
      query = ActiveRecord::Base.sanitize_sql_array([<<-SQL.squish, email])
        SELECT dc_company_employees.uuid AS company_employee_uuid,
          dc_company_employees.id as company_employee_id,
          dc_company_employees.*, dc_employees.* FROM dc_company_employees
          INNER JOIN dc_employees ON dc_employees.id = dc_company_employees.dc_employee_id
          WHERE email = ? LIMIT 1
      SQL

      new(ApplicationRecord.connection.execute(query).try(:first))
    end

    def self.find_by_company_employee_id(company_employee_id)
      query = ActiveRecord::Base.sanitize_sql_array([<<-SQL.squish, company_employee_id])
        SELECT dc_company_employees.uuid AS company_employee_uuid,
          dc_company_employees.id as company_employee_id,
          dc_company_employees.*, dc_employees.* FROM dc_company_employees
          INNER JOIN dc_employees ON dc_employees.id = dc_company_employees.dc_employee_id
          WHERE dc_company_employees.id = ?
          ORDER BY dc_company_employees.created_at DESC
          LIMIT 1
      SQL

      new(ApplicationRecord.connection.execute(query).try(:first))
    end

    def company
      @company ||= Company.find(dc_company_id)
    end

    def fullname
      [first_name, last_name].joins(' ')
    end
  end
end
