class CreateNavQuestionnaireRules < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_questionnaire_rules do |t|
      t.string :question_key
      t.datetime :deleted_at

      t.references :nav_questionnaire, foreign_key: { on_delete: :cascade }
      t.references :nav_rule, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
