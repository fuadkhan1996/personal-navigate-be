class CreateNavAssessmentActionResults < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_assessment_action_results do |t|
      t.jsonb :result_data, default: {}
      t.references :nav_activity_action, foreign_key: true
      t.references :nav_assessment, foreign_key: { on_delete: :cascade }
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
