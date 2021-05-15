class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.integer :priority, null: false
      t.string :syslog_version, null: false
      t.timestamp :timestamp, null: false
      t.string :host, null: false
      t.string :app_name, null: false
      t.string :process_name, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
