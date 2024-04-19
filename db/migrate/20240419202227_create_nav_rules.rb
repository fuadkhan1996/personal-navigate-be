class CreateNavRules < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_rules do |t|
      t.string :title
      t.string :description
      t.jsonb :data, default: {}
      t.datetime :deleted_at

      t.references :dc_company, foreign_key: { on_delete: :cascade }
      t.references :dc_company_employee, foreign_key: true

      t.timestamps
    end
  end
end
