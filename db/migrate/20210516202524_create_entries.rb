class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :log, foreign_key: true
      t.string :action_name, null: false
      t.string :controller_name, null: false
      t.string :country_code
      t.string :format, null: false
      t.string :ip, null: false
      t.string :user_agent, null: false
      t.timestamp :timestamp, null: false

      t.timestamps
    end
  end
end
