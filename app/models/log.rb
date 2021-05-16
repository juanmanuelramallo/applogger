# == Schema Information
#
# Table name: logs
#
#  id             :bigint           not null, primary key
#  app_name       :string           not null
#  host           :string           not null
#  message        :text             not null
#  priority       :integer          not null
#  process_name   :string           not null
#  syslog_version :string           not null
#  timestamp      :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Log < ApplicationRecord
  has_one :entry
end
