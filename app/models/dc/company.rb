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
  end
end
