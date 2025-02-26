class CreateActivityTriggers < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_activity_triggers do |t|
      t.references :activity, foreign_key: { on_delete: :cascade, to_table: :nav_activities }
      t.references :trigger, foreign_key: { on_delete: :cascade, to_table: :nav_triggers }

      t.timestamps
    end

    add_index :nav_activity_triggers, [:activity_id, :trigger_id], unique: true, name: 'index_nav_activity_triggers_on_activity_and_trigger'
    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO nav_activity_triggers (activity_id, trigger_id, created_at, updated_at)
          SELECT t.nav_activity_id, t.id, NOW(), NOW()
          FROM nav_triggers t
          WHERE NOT EXISTS (
            SELECT 1
            FROM nav_activity_triggers at
            WHERE at.activity_id = t.nav_activity_id
              AND at.trigger_id = t.id
          );
        SQL
      end
    end
  end
end
