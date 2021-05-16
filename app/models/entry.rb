# == Schema Information
#
# Table name: entries
#
#  id              :bigint           not null, primary key
#  action_name     :string           not null
#  controller_name :string           not null
#  country_code    :string
#  format          :string           not null
#  ip              :string           not null
#  timestamp       :datetime         not null
#  user_agent      :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  log_id          :bigint
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
