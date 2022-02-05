class AddSearchableToLogs < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TABLE logs
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        to_tsvector('english', coalesce(message, ''))
      ) STORED;
    SQL
  end

  def down
    remove_column :logs, :searchable
  end
end
