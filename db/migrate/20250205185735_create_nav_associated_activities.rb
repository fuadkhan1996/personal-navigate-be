class CreateNavAssociatedActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_associated_activities do |t|
      t.references :activity, foreign_key: { on_delete: :cascade, to_table: :nav_activities }
      t.references :company, foreign_key: { on_delete: :cascade, to_table: :dc_companies }
      t.references :assessment, foreign_key: { on_delete: :cascade, to_table: :nav_assessments }

      t.timestamps
    end
  end
end
