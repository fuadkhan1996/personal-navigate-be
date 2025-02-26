class AddCompanyIdAndCompanyEmployeeIdInNavTriggers < ActiveRecord::Migration[7.1]
  def change
    add_reference :nav_triggers, :company, foreign_key: { on_delete: :cascade, to_table: :dc_companies }
    add_reference :nav_triggers, :company_employee, foreign_key: { on_delete: :cascade, to_table: :dc_company_employees }

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE nav_triggers
          SET
            company_id = COALESCE(nav_triggers.company_id, nav_activities.dc_company_id),
            company_employee_id = COALESCE(nav_triggers.company_employee_id, nav_activities.dc_company_employee_id)
          FROM nav_activity_triggers
          JOIN nav_activities ON nav_activity_triggers.activity_id = nav_activities.id
          WHERE nav_activity_triggers.trigger_id = nav_triggers.id
            AND (nav_triggers.company_id IS NULL OR nav_triggers.company_employee_id IS NULL);
        SQL
      end
    end
  end
end
