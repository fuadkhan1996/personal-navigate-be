class AddCompletedAtFieldInNavAssessmentActionResults < ActiveRecord::Migration[7.1]
  def change
    add_column :nav_assessment_action_results, :completed_at, :datetime
  end
end
