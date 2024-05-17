class CreateNavQuestionnaireActions < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_questionnaire_actions do |t|
      t.jsonb :criteria, default: {}
      t.datetime :deleted_at
      t.references :nav_action, foreign_key: { on_delete: :cascade }
      t.references :nav_questionnaire, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
