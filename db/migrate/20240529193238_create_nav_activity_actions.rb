class CreateNavActivityActions < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_activity_actions do |t|
      t.string :title
      t.string :description
      t.jsonb :details, default: {}
      t.integer :order
      t.datetime :deleted_at
      t.references :nav_action, foreign_key: { on_delete: :cascade }
      t.references :nav_activity, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
