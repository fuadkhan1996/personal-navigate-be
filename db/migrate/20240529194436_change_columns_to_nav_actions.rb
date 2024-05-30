class ChangeColumnsToNavActions < ActiveRecord::Migration[7.1]
  def change
    add_column :nav_actions, :action_kind, :string
    reversible do |dir|
      dir.up do
        remove_index :nav_actions, %i[title dc_company_employee_id], unique: true
        remove_reference :nav_actions, :dc_company_employee, index: true, foreign_key: true
        remove_reference :nav_actions, :dc_company, index: true, foreign_key: { on_delete: :cascade }
        remove_reference :nav_actions, :nav_action_type, index: true, foreign_key: true
        remove_column :nav_actions, :details, :jsonb
      end

      dir.down do
        add_column :nav_actions, :details, :jsonb
        add_reference :nav_actions, :nav_action_type, index: true, foreign_key: true
        add_reference :nav_actions, :dc_company, index: true, foreign_key: { on_delete: :cascade }
        add_reference :nav_actions, :dc_company_employee, index: true, foreign_key: true
        add_index :nav_actions, %i[title dc_company_employee_id], unique: true
      end
    end
  end
end
