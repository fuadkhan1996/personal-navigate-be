class AddPinnedFlagInNavAssociatedActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :nav_associated_activities, :pinned, :boolean, default: false

    # Backfill existing rows to set pinned = false
    reversible do |dir|
      dir.up do
        execute("UPDATE nav_associated_activities SET pinned = false WHERE pinned IS NULL")
      end
    end
  end
end
