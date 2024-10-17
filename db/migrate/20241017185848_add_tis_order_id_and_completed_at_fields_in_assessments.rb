class AddTisOrderIdAndCompletedAtFieldsInAssessments < ActiveRecord::Migration[7.1]
  def change
    add_column :nav_assessments, :tis_order_id, :bigint
    add_column :nav_assessments, :completed_at, :datetime
  end
end
