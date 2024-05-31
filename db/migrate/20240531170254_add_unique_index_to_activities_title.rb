class AddUniqueIndexToActivitiesTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :nav_activities, [:title, :dc_company_id], unique: true
  end
end
