# frozen_string_literal: true

module Dc
  class Employee
    include ActiveModel::API
    include Dc::Api::Employee
    include Authable

    attr_accessor :access_token, :refresh_token

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
        SELECT * FROM dc_employees WHERE email = ? LIMIT 1
      SQL

      new(ApplicationRecord.connection.execute(query).try(:first))
    end
  end
end
