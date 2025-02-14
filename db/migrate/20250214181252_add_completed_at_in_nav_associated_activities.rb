class AddCompletedAtInNavAssociatedActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :nav_associated_activities, :completed_at, :datetime
  end
end
