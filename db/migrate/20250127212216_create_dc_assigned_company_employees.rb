class CreateDcAssignedCompanyEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :dc_assigned_company_employees do |t|
      t.references :company_employee, foreign_key: { on_delete: :cascade, to_table: :dc_company_employees }
      t.references :company_connection, foreign_key: { on_delete: :cascade, to_table: :dc_company_connections }

      t.timestamps
    end

    add_index :dc_assigned_company_employees,
              %i[company_employee_id company_connection_id],
              unique: true,
              name: 'idx_unique_assigned_employee_connection'
  end
end
