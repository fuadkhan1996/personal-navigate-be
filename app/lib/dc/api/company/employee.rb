module Dc
  module Api
    module Company
      module Employee
        def self.lookup_by_email_and_company_type(email, company_type)
          condition = company_type.blank? ? "dc_company_types.name != 'Account'" : 'dc_company_types.name = ?'
          query = ActiveRecord::Base.sanitize_sql_array([<<-SQL.squish, email, company_type])
            SELECT dc_company_employees.*, dc_employees.email as email,
              dc_employees.first_name as first_name, dc_employees.last_name as last_name
              FROM dc_company_employees
              INNER JOIN dc_employees ON dc_employees.id = dc_company_employees.dc_employee_id
              INNER JOIN dc_companies ON dc_companies.id = dc_company_employees.dc_company_id
              INNER JOIN dc_company_types ON dc_company_types.id = dc_companies.comp_type_id
              WHERE dc_employees.email = ? AND #{condition}
              ORDER BY dc_company_employees.created_at ASC LIMIT 1
          SQL

          ApplicationRecord.connection.execute(query).try(:first)
        end
      end
    end
  end
end
