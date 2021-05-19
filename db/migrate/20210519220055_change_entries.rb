class ChangeEntries < ActiveRecord::Migration[6.1]
  def change
    change_table :entries, bulk: true do |t|
      t.remove :action_name
      t.remove :controller_name

      t.column :path, :string, default: ''
      t.column :query_string, :string, null: false, default: ''
      t.column :referrer, :string, null: false, default: ''
      t.column :http_method, :string, default: ''
      t.column :app_name, :string, default: ''
      t.column :process_name, :string, default: ''
    end
  end
end
