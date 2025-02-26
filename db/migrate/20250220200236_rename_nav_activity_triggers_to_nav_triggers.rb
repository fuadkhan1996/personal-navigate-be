class RenameNavActivityTriggersToNavTriggers < ActiveRecord::Migration[7.1]
  def change
    rename_table :nav_activity_triggers, :nav_triggers
  end
end
