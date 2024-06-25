class AddNavActivityTriggerReferenceToNavAssessmentActionResults < ActiveRecord::Migration[7.1]
  def change
    add_reference :nav_assessment_action_results, :nav_activity_trigger, foreign_key: true, index: true
  end
end
