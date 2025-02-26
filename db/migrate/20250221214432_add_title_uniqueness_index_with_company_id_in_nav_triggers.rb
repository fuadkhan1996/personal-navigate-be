class AddTitleUniquenessIndexWithCompanyIdInNavTriggers < ActiveRecord::Migration[7.1]
  def change
    add_index :nav_triggers, %i[title company_id], unique: true, name: 'index_nav_triggers_on_title_and_company'
  end
end
