# frozen_string_literal: true

module Dc
  module Api
    module Employee
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def find(id)
          query = ActiveRecord::Base.sanitize_sql_array([<<-SQL.squish, id])
            SELECT * FROM dc_employees WHERE id = ? LIMIT 1
          SQL

          new(ApplicationRecord.connection.execute(query).try(:first))
        end
      end
    end
  end
end
