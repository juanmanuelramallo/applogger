# == Schema Information
#
# Table name: entries
#
#  id           :bigint           not null, primary key
#  app_name     :string           default("")
#  country_code :string
#  format       :string           not null
#  http_method  :string           default("")
#  ip           :string           not null
#  path         :string           default("")
#  process_name :string           default("")
#  query_string :string           default(""), not null
#  referrer     :string           default(""), not null
#  timestamp    :datetime         not null
#  user_agent   :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  log_id       :bigint
#
# Indexes
#
#  index_entries_on_log_id  (log_id)
#
# Foreign Keys
#
#  fk_rails_...  (log_id => logs.id)
#
class Entry < ApplicationRecord
  belongs_to :log
end
