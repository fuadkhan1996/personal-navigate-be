class CreateNavActionTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :nav_action_types do |t|
      t.string :title
      t.string :action_kind
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
