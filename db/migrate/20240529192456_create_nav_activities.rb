class CreateNavActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_activities do |t|
      t.string :title
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
