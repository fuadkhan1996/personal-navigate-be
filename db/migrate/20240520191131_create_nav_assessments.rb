class CreateNavAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_assessments do |t|
      t.string :title
      t.jsonb :form_data, default: {}
      t.references :nav_questionnaire, foreign_key: { on_delete: :cascade }
      t.references :dc_company, foreign_key: { on_delete: :cascade }
      t.references :dc_company_employee, foreign_key: true
      t.references :account, foreign_key: { to_table: :dc_companies }
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
