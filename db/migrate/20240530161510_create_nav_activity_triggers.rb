class CreateNavActivityTriggers < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_activity_triggers do |t|
      t.string :title
      t.string :description
      t.jsonb :criteria, default: {}
      t.datetime :deleted_at
      t.references :nav_questionnaire, foreign_key: { on_delete: :cascade }
      t.references :nav_activity, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
