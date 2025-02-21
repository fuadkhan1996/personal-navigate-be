class AddAssociatedActivityReferenceInActionResultTriggers < ActiveRecord::Migration[7.1]
  def change
    add_reference :nav_assessment_action_result_triggers, :associated_activity, foreign_key: { on_delete: :cascade, to_table: :nav_associated_activities }
  end
end
