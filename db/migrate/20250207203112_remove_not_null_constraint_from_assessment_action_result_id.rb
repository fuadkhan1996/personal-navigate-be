class RemoveNotNullConstraintFromAssessmentActionResultId < ActiveRecord::Migration[7.1]
  def up
    change_column_null :nav_assessment_action_result_triggers, :assessment_action_result_id, true
  end

  def down
    change_column_null :nav_assessment_action_result_triggers, :assessment_action_result_id, false
  end
end
