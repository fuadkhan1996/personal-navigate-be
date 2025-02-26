class AddTitleUniquenessIndexWithCompanyIdInNavTriggers < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        duplicates = execute(<<~SQL)
          SELECT id, title, company_id, ROW_NUMBER() OVER (PARTITION BY title, company_id ORDER BY id) AS row_num
          FROM nav_triggers
          WHERE (title, company_id) IN (
            SELECT title, company_id
            FROM nav_triggers
            GROUP BY title, company_id
            HAVING COUNT(*) > 1
          )
        SQL

        duplicates.each do |row|
          next if row['row_num'].to_i == 1 # Skip the first occurrence (it remains unchanged)

          # Append "(n)" to the title for duplicates
          new_title = "#{row['title']} (#{row['row_num'] - 1})"
          execute("UPDATE nav_triggers SET title = '#{new_title}' WHERE id = #{row['id']}")
        end
      end
    end

    add_index :nav_triggers, %i[title company_id], unique: true, name: 'index_nav_triggers_on_title_and_company'
  end
end
