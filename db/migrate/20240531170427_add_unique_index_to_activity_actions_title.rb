class AddUniqueIndexToActivityActionsTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :nav_activity_actions, [:title, :nav_activity_id], unique: true
  end
end
