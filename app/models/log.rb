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
#  searchable     :tsvector
#  syslog_version :string           not null
#  timestamp      :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_logs_on_searchable  (searchable) USING gin
#
class Log < ApplicationRecord
  include PgSearch::Model

  has_one :entry

  pg_search_scope :search_by_message,
    against: :message,
    using: {
      tsearch: {
        dictionary: "english",
        tsvector_column: "searchable"
      }
    }
end
