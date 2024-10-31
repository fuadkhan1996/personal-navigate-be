class CreateNavAssessmentActionResultTriggers < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_assessment_action_result_triggers do |t|
      t.references :activity_trigger, null: false, foreign_key: { to_table: :nav_activity_triggers, on_delete: :cascade }
      t.references :assessment_action_result, null: false, foreign_key: { to_table: :nav_assessment_action_results, on_delete: :cascade }
      t.timestamps
    end

    add_index :nav_assessment_action_result_triggers, [:activity_trigger_id, :assessment_action_result_id], unique: true, name: 'index_nav_assessment_action_result_triggers'
  end
end
